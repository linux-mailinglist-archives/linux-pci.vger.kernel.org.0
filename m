Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E409B4DA0F5
	for <lists+linux-pci@lfdr.de>; Tue, 15 Mar 2022 18:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350503AbiCORPn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Mar 2022 13:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241638AbiCORPm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Mar 2022 13:15:42 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B490325C65
        for <linux-pci@vger.kernel.org>; Tue, 15 Mar 2022 10:14:29 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w8so854325pll.10
        for <linux-pci@vger.kernel.org>; Tue, 15 Mar 2022 10:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xgus+7qmbSJ9nJIqIcIxl/J+AKyxRbFiTCWjU46hP/c=;
        b=hQkHI/A3LRXnPnAlt7EGrixwAoVxbfQnxHbS174svfz/cEFEWbHmIrVQ+n9av6Z9lF
         CxmZ6608U+o2fZKbzJ0PpnteN5mTfDaXyRii/kkF4qaoKtqPYuAs6wtQiDmOBt/2ZAM5
         WBJt87LUxcPe/6tI2cP92k7ist6mx/DTYf5Iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xgus+7qmbSJ9nJIqIcIxl/J+AKyxRbFiTCWjU46hP/c=;
        b=4ztz/s7TlZvYFkds6iilMVgIeNUWuPykfru/HIzsnBeyAOkWF4wnOMPM88HEbqel0/
         XgWpz7iZkV3F34CBxKyqN3ocwqaQksSRBA6LwwgFAlWJ+SySC/hp6oscrALhMu8NhFtt
         DJnVhPESzyID7q71DyQUshALdt0jHGFvhbS87/btR7+8Jf08tEBg/3DzVWW+EVnN2Pgf
         9+EMupJ2Amq/bIVdgJUTRF9+MkGJLp3X0ajMAbTLOWdiIpk+CZMUt8cCZxKHb61+Tdur
         WcHcAtXD9VzWdLFCstBjUnENoN3tgZkmXshvN/+eo+oOWWNecDOi/SswWeFwUqv4m6g+
         fiuw==
X-Gm-Message-State: AOAM532Pg0P1JSts9e7YbI5xU8vr/HMh1fhfPOwZDdQNxhGwXGKuQ54F
        c4r33W6AKl6B3ta9mIJy8xbqwg==
X-Google-Smtp-Source: ABdhPJyLaWXVpyvW4Mh3z0KkiQQ80MjXoNmNJlknK49fD5o3TURQH1gKAkjamZe2Af4tq/7vXjdNFQ==
X-Received: by 2002:a17:902:cccf:b0:14e:eb44:40a1 with SMTP id z15-20020a170902cccf00b0014eeb4440a1mr29427014ple.111.1647364469225;
        Tue, 15 Mar 2022 10:14:29 -0700 (PDT)
Received: from ebps (cpe-75-80-179-40.san.res.rr.com. [75.80.179.40])
        by smtp.gmail.com with ESMTPSA id mw7-20020a17090b4d0700b001b8baf6b6f5sm3909768pjb.50.2022.03.15.10.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 10:14:28 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:14:25 -0700
From:   Eric Badger <ebadger@purestorage.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        ebadger@purestorage.com
Subject: Re: [PATCH v2] PCI/AER: Handle Multi UnCorrectable/Correctable
 errors properly
Message-ID: <20220315171425.GA1521135@ebps>
References: <20220315050842.120063-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315050842.120063-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 15, 2022 at 05:08:42AM +0000, Kuppuswamy Sathyanarayanan wrote:
> This error can be reproduced by making following changes to the
> aer_irq() function and by executing the given test commands.
> 
>  static irqreturn_t aer_irq(int irq, void *context)
>          struct aer_err_source e_src = {};
> 
>          pci_read_config_dword(rp, aer + PCI_ERR_ROOT_STATUS,
> 				&e_src.status);
>  +       pci_dbg(pdev->port, "Root Error Status: %04x\n",
>  +		e_src.status);
>          if (!(e_src.status & AER_ERR_STATUS_MASK))
>                  return IRQ_NONE;
> 
>  +       mdelay(5000);
> 
>  # Prep injection data for a correctable error.
>  $ cd /sys/kernel/debug/apei/einj
>  $ echo 0x00000040 > error_type
>  $ echo 0x4 > flags
>  $ echo 0x891000 > param4
> 
>  # Root Error Status is initially clear
>  $ setpci -s <Dev ID> ECAP0001+0x30.w
>  0000
> 
>  # Inject one error
>  $ echo 1 > error_inject
> 
>  # Interrupt received
>  pcieport <Dev ID>: AER: Root Error Status 0001
> 
>  # Inject another error (within 5 seconds)
>  $ echo 1 > error_inject
> 
>  # No interrupt received, but "multiple ERR_COR" is now set
>  $ setpci -s <Dev ID> ECAP0001+0x30.w
>  0003
> 
>  # Wait for a while, then clear ERR_COR. A new interrupt immediately
>    fires.
>  $ setpci -s <Dev ID> ECAP0001+0x30.w=0x1
>  pcieport <Dev ID>: AER: Root Error Status 0002
> 
> Currently, the above issue has been only reproduced in the ICL server
> platform.
> 
> [Eric: proposed reproducing steps]

Hmm, this differs from the procedure I described on v1, and I don't
think will work as described here.

Eric
