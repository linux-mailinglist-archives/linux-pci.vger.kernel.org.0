Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 684F6BC51D
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2019 11:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504386AbfIXJoe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Sep 2019 05:44:34 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43186 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504385AbfIXJoe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Sep 2019 05:44:34 -0400
Received: by mail-lj1-f196.google.com with SMTP id n14so1171577ljj.10;
        Tue, 24 Sep 2019 02:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qWmkYOt5baX4aQhfwtcn7sK3MbxZygEY/vjhPk+RANo=;
        b=my1sFslfglrChUW8BP+LY2FgUGJhFzu0gGbqOwcTkkY6bJDYPtGbsHOeMTVKW7u44F
         cvYXEKBuIMP2Affg1ToBji7xOJRIo9xt4FlEQixq1vdIr0b5T4duosOtAbBbskr5lMGI
         F/1KSsutkiax9EvNAilMPJIHFpKmOSeqprgzO9YCxerBSLFiQrTlUdVntfqR8z6mP4d1
         WVb5yUSkMU2c4hv1iIkDUegV82HLWv1IZT/7df2jGvgudT4ntxkEBpHP65t4WCHU0prV
         xAH/28g1LB2p4wDuPXdZ/7/41iP62Pa4dKRaGitvykJeYqxOHPhyLVbiqyll4EBuRXxL
         Kmew==
X-Gm-Message-State: APjAAAV8uECy2WFsFpgV3ejhURktHCw/tDCxKNK+o82e9Q+WQFNnJWeV
        71NKpUcJlJ/hF/B0v4SKw25XOskPBkA=
X-Google-Smtp-Source: APXvYqy7yqmHPXCMavncOwv48hYUCpyjzwtT4Hi6SFKa1Kz7OZBX5JuIRCa9xsfDJta7eL/dwSNAXg==
X-Received: by 2002:a2e:a41b:: with SMTP id p27mr1374496ljn.104.1569318271776;
        Tue, 24 Sep 2019 02:44:31 -0700 (PDT)
Received: from [10.10.124.58] (99-48-196-88.sta.estpak.ee. [88.196.48.99])
        by smtp.gmail.com with ESMTPSA id v1sm332317lfe.34.2019.09.24.02.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 02:44:31 -0700 (PDT)
Subject: Re: [PATCH v3 18/26] scsi: pm80xx: Use PCI_STD_NUM_BARS
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>,
        linux-scsi@vger.kernel.org, Jack Wang <jinpu.wang@cloud.ionos.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20190916204158.6889-1-efremov@linux.com>
 <20190916204158.6889-19-efremov@linux.com> <yq1wody4eml.fsf@oracle.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <2c240ad0-80b1-3c2e-72a9-a3139f2eae14@linux.com>
Date:   Tue, 24 Sep 2019 12:44:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <yq1wody4eml.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 24.09.2019 05:22, Martin K. Petersen wrote:
> 
> Denis,
> 
>> Replace the magic constant (6) with define PCI_STD_NUM_BARS
>> representing the number of PCI BARs.
> 
> Applied to 5.4/scsi-fixes. Thanks!
> 

This constant PCI_STD_NUM_BARS is introduced in the first patch [01/26].
I'm afraid that this patch without the first one will break the compilation.
This patchset is dedicated to Bjorn's tree. Sorry for confusing you.

Thanks,
Denis
