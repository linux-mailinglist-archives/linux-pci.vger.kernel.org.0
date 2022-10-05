Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAF55F5578
	for <lists+linux-pci@lfdr.de>; Wed,  5 Oct 2022 15:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiJENdV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Oct 2022 09:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiJENdU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Oct 2022 09:33:20 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A7479EDB
        for <linux-pci@vger.kernel.org>; Wed,  5 Oct 2022 06:33:20 -0700 (PDT)
Received: by mail-pj1-f41.google.com with SMTP id h8-20020a17090a054800b00205ccbae31eso1512446pjf.5
        for <linux-pci@vger.kernel.org>; Wed, 05 Oct 2022 06:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nDz/mypA3pBMuVq7axyrfxfpHKJJ2GOzegFDtXQ9wkw=;
        b=gmG0dz8uCabfvPifTOP8eivCPUgnHo3UMsWMu6VSY1F5h6kT97y0hziGeosPyIj2Xr
         j8ur5Dj2aHO7fturlfi8kOKhHooeWLMsZ8N4AT9bdrq1iq8aTSDmnXN6UYfnR4PBaQzC
         kGCWgg+WbIjAj1F9NSAZzpJYDJfGmaQueL7RbRwufJ7g3nl2kdzLxvBofcyFlwjUg1hD
         AyYkzY7jQ+79YLRNRkaI3W/XR+alEJnNredc+Ks55rhYeigOhZsZtDuvIbihYMj52oFL
         APClZzjLMTzO7Srje6Cd4ObkJr0/bLThbm1u00MT4iA+JFa+AeDhJyKCPozfQPIQN5hC
         ZBxQ==
X-Gm-Message-State: ACrzQf2oEMA189mCNGc6gmat8K8MNg+OGEsGA+uH50Nyk0GXoqCZTNkE
        Hx7kQNtMnF7zu6L35hPFERo=
X-Google-Smtp-Source: AMsMyM48aCKZf4N9qRrQBcsbJA+eqKVBl9N5nYXRRx70NrWzruGSxhmCOprRwcWqLm+PVsKU8nS2Dg==
X-Received: by 2002:a17:90b:314b:b0:203:41c:2dbb with SMTP id ip11-20020a17090b314b00b00203041c2dbbmr5117346pjb.18.1664976799390;
        Wed, 05 Oct 2022 06:33:19 -0700 (PDT)
Received: from rocinante (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id n12-20020a170902d2cc00b0017da2798025sm8256744plc.295.2022.10.05.06.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 06:33:18 -0700 (PDT)
Date:   Wed, 5 Oct 2022 22:33:15 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     linuxkernelml@undead.fr
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: pci=no_e820 required for Clevo laptop
Message-ID: <Yz2Hm99xHaJmdN6g@rocinante>
References: <5d8ae0a2-1c0c-11ab-a33c-9b57bd087733@undead.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d8ae0a2-1c0c-11ab-a33c-9b57bd087733@undead.fr>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

(+CC Bjorn and Hans directly for visibility)

Hi Florent,

I am sorry that you are having issues!

> As per
> https://www.kernel.org/doc/Documentation/admin-guide/kernel-parameters.txt,
> I am sending you this email to inform you that I need to set "pci=no_e820"
> parameter to get the SSD and touchpad working.
> 
> ---------------------------------------------------------------------
> 
> Dmidecode:
> 
> BIOS Information
>     Vendor: INSYDE Corp.
>     Version: 1.07.02TPCS
>     Release Date: 08/19/2020
> 
>     BIOS Revision: 7.2
>     Firmware Revision: 7.2
> Handle 0x0001, DMI type 1, 27 bytes
> System Information
>     Manufacturer: PC Specialist LTD
>     Product Name: NL4x_NL5xLU
> Base Board Information
>     Manufacturer: CLEVO
>     Product Name: NL4XLU
> 
> uname -a
> Linux topik 5.19.0-2-amd64 #1 SMP PREEMPT_DYNAMIC Debian 5.19.11-1
> (2022-09-24) x86_64 GNU/Linux

We need a little bit more information, if you have the time, to collect
that will be of great help to us with troubleshooting this.

Would you be able to collect output from the following:

  - lspci -vvv
  - dmesg (preferably since the system started)

Then, either attach these here as text attachments, or better yet, open
a bug report against the PCI driver on Kernel's Bugzilla at

  https://bugzilla.kernel.org/

and include as much information as possible about your system as you can,
plus the details mentioned above.  That would help greatly.

Thank you!

	Krzysztof
