Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBD841CAF1
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 19:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345499AbhI2RQa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 13:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345497AbhI2RQ3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Sep 2021 13:16:29 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4ECC06161C;
        Wed, 29 Sep 2021 10:14:48 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id bd28so11234796edb.9;
        Wed, 29 Sep 2021 10:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OQKF+RLkOKzo9hZLWlJSlFW0i6TdEuGYzqVjwQH02LE=;
        b=eG0HL3t+blVG+2HjIgZmO04iNkhYAM8BXnHAM6Om9vEp012pWtJmYZPsqy5Z+hEQ9G
         sZP6Cz5xzHbhB2uL8xmzgk82e0hHJysUBWeyf0UWLUHmTvZbJBrQ5BmfDuN0Cl7XSGN1
         Tns2oU+fzP/r2SiZWC3Eu51wMAYpUxENh4Vxj1Us27aG7BbFSh+TXLtYE4Nf0I1a+CxP
         HMEhgVr49xOG1pFet4UzHMbdEH+bQntBcmdiRQkXWVLAXJ8zWIuGB85ii5bwVdaBaAIO
         dzr72iTbqsWRAqZVsypkmAiAgACKt/ukjAYlc9dVJdQeMueyuB8TRm5pmMC3ZIVWMjZ9
         Sm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OQKF+RLkOKzo9hZLWlJSlFW0i6TdEuGYzqVjwQH02LE=;
        b=3S3JL03lNM90Fmjy2UU76lkU3ForEymKS3MMQAJt3ljcVGBZUGPPK+LabgIgtxYQh5
         chfGdkzqdVBFzNafqwIgLfcCeYHiTp5q15B+jK+qOAaqG16CHRkp/tN46RA3kMkHNAxv
         +YKAOTgfkOWcVvXhVgIUM8XZC92GIhdgyX5Omsrgd6YHyh89ioxDC0tmdoaSE2kY/D7j
         wMUqvbZn6yAj06A0aRH3oFUSkRPyOK+V0Zh/Ri57fyy1UGVvQVDPkzaKAG1CKB2I8w4c
         V8Aoz81Rau0vA2++B9XGyAlo4NpyQqoZ/AI/5GeNSGLUgtDik461rH6MrFxK7sVw+rn1
         C+2g==
X-Gm-Message-State: AOAM531iNZs8yGokVBen8pwWmpZ7nziD1DRcZs6QIfpedpwXDPQfcFhL
        EoWW48SxcOsiC2E4djQZJKw=
X-Google-Smtp-Source: ABdhPJyuMSo2XG3S9Q6rcz0SPuJjiu4vfEzdQ0SoiodnSquZ+zn4DQXuVy3riDPoxBDKiT416+vGOw==
X-Received: by 2002:a17:906:564e:: with SMTP id v14mr1006746ejr.424.1632935687100;
        Wed, 29 Sep 2021 10:14:47 -0700 (PDT)
Received: from [192.168.1.97] ([49.236.51.203])
        by smtp.gmail.com with ESMTPSA id cr9sm266282edb.17.2021.09.29.10.14.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 10:14:46 -0700 (PDT)
Subject: Re: [PATCH v2 0/7] PCI: ACPI: Get rid of struct pci_platform_pm_ops
 and clean up code
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20210928232823.GA748352@bhelgaas>
From:   Ferry Toth <fntoth@gmail.com>
Message-ID: <f6be0339-5b11-8c3b-ef5c-47e50e878e2d@gmail.com>
Date:   Wed, 29 Sep 2021 19:14:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210928232823.GA748352@bhelgaas>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

Op 29-09-2021 om 01:28 schreef Bjorn Helgaas:
> [+cc Ferry]
> 
> On Mon, Sep 20, 2021 at 08:52:19PM +0200, Rafael J. Wysocki wrote:
>> Hi All,
>>
>> As explained in the changelog of patch [2/7], using struct pci_platform_pm_ops
>> for ACPI is not particularly beneficial, so it is better to get rid of it and
>> call the functions pointed to by it directly from the PCI core.
>>
>> However, struct pci_platform_pm_ops is also used by the Intel MID support code,
>> but it is actually better to call the MID PM function directly from the PCI
>> core either, which is done in patch [1/7].
>>
>> After these changes, patch [3/7] removes struct pci_platform_pm_ops and the
>> rest is just cleanups and some code consolidation on top of that.
> 
> I like these a lot.  Not sure exactly where everything is after the
> conversation with Ferry.  Let me know if I should be doing anything.
> 
I will happily retest likely on Sunday after I return from short holiday 
and report back here.
