Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC00C6545B6
	for <lists+linux-pci@lfdr.de>; Thu, 22 Dec 2022 18:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiLVRpr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Dec 2022 12:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiLVRpq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Dec 2022 12:45:46 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9293A2
        for <linux-pci@vger.kernel.org>; Thu, 22 Dec 2022 09:45:42 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id gv5-20020a17090b11c500b00223f01c73c3so5897769pjb.0
        for <linux-pci@vger.kernel.org>; Thu, 22 Dec 2022 09:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0sze1nGreiAXsTywGDPG70IW4R2b83boMaSQmXNC/vE=;
        b=i1UUDCYNa993+xaGBjfg/9QfwtkWdRmcSoJRlKzDgqF9Rha4/nnkfkKA/zpGHmNqbG
         HaXwo9fbMf2knV8j5gQtR49wtmQfajX6LYcmmUdGfpcYF78TexfpGlZIMFVnPu0KlU1V
         G4qvDNg3dzSEbUGr1LjKOBhkCU9MBFgk7zRbZc/NU5hUafDmaB0Bj9zYQIEopSGEU/4h
         XjK6w8iPef1Pse6CTBSj5WgRz498R6rpQpFysqVsRZHQSA/d1BcmFJL5rApQ0XrPGRbD
         sO8evz8sa9Oa+uI2ChsTql7Zb0HTwUuoPOoZuynHjA4QzGO/Z59UZPXD9l4De9FuaD4i
         g1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0sze1nGreiAXsTywGDPG70IW4R2b83boMaSQmXNC/vE=;
        b=msORnqke3PRhRCVKSO7EEMRMwSlS8CSz2VucncDTPibNwkG67pFALMaZkqgU2e/AE9
         uAh15DZcZ1/+248DUY5I7o8kA7tphTYEP2fCRA1orLokBZSXH2nactaDw6MaI8jjhP9c
         0SRkSbp4xQg8r7OKkYC58zDejTlBxJYwwZWb4xeUlyQVHXyTUd/M0cOAVdLqqQVp8wgK
         2lquNwJdCtv/O3ulPVWcAchLB642kuHxq/QJEnr5n4ZNLr1C7i7g/XQkwGZsOEd1hggw
         R/MpJsyw/RX2Lrly3fUyy2dbCxgyDJLMY6i65MkRlBCAxT/N/6C1LI+h5NEFc4bHmmU/
         GxIA==
X-Gm-Message-State: AFqh2krhvOWwWnUyOj5uUflWsCrAJrtoYhEJkRMS4hexzyUnvwL9iGce
        UfnbLZXbyCjs8stNevaANbim
X-Google-Smtp-Source: AMrXdXt51bcZrZbcp7TU3euTB/meFVmLtdr0W5ttIGWdBxJS04MNVOb1fR1o9I4kVD5im3QkLli5lA==
X-Received: by 2002:a17:90b:35c6:b0:219:5b39:9120 with SMTP id nb6-20020a17090b35c600b002195b399120mr7210829pjb.41.1671731141990;
        Thu, 22 Dec 2022 09:45:41 -0800 (PST)
Received: from thinkpad ([117.217.177.177])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090a65ca00b00218cd71781csm859075pjs.51.2022.12.22.09.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 09:45:40 -0800 (PST)
Date:   Thu, 22 Dec 2022 23:15:32 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Aman Gupta <aman1.gupta@samsung.com>, shradha.t@samsung.com,
        pankaj.dubey@samsung.com, kishon@ti.com, lpieralisi@kernel.org,
        kw@linux.com, shuah@kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
Subject: Re: [PATCH] selftests: pci: pci-selftest: add support for PCI
 endpoint driver test
Message-ID: <20221222174532.GA59500@thinkpad>
References: <CGME20221007053726epcas5p357c35abb79327fee6327bc6493e0178c@epcas5p3.samsung.com>
 <20221007053934.5188-1-aman1.gupta@samsung.com>
 <641d1e50-a9d0-dc15-be76-07b8ace25dae@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <641d1e50-a9d0-dc15-be76-07b8ace25dae@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 22, 2022 at 09:58:30AM -0700, Shuah Khan wrote:
> On 10/6/22 23:39, Aman Gupta wrote:
> > This patch enables the support to perform selftest on PCIe endpoint
> > driver present in the system. The following tests are currently
> > performed by the selftest utility
> > 
> > 1. BAR Tests (BAR0 to BAR5)
> > 2. MSI Interrupt Tests (MSI1 to MSI32)
> > 3. Read Tests (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > 4. Write Tests (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > 5. Copy Tests (For 1, 1024, 1025, 1024000, 1024001 Bytes)
> > 
> > Signed-off-by: Aman Gupta <aman1.gupta@samsung.com>
> > Signed-off-by: Padmanabhan Rajanbabu <p.rajanbabu@samsung.com>
> 
> Adding Bjorn Helgaas to the thread.
> 
> Adding pcit test under selftests is good. There is another pcitest
> under tools/pci. I would like to see if the existing code in
> tools/pci/pcitest.c can be leveraged.
> 
> As part of this test work, also look into removing tools/pci so
> we don't have to maintain duplicate code in two places.
> 

It has been agreed in a thread with Greg [1] to {re}move the tests under
tools/pci and utilize the kselftest.

Thanks,
Mani

[1] https://lore.kernel.org/lkml/Y2FTWLw0tKuZ9Cdl@kroah.com/

> thanks,
> -- Shuah

-- 
மணிவண்ணன் சதாசிவம்
