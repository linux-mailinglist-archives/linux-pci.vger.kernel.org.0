Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FB82209DD
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 12:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgGOKVv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 06:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgGOKVv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jul 2020 06:21:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A09C061755;
        Wed, 15 Jul 2020 03:21:50 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id rk21so1626871ejb.2;
        Wed, 15 Jul 2020 03:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lnCPkOcNS67xMF6t5lbmMUCC2k2JGvmiyTaTvXGTcLg=;
        b=tDAs7oEw7lD9cZ2cRvqG5IiEqJikiKKCwNR6636f4Jp2L4gEMBO2whNLP3z7xz3CcE
         eY0f0jgqgO0GCey7Pw+UOphpDqgbMlJmq9phRN0mRY+DRoSKFlGSs/woT3FSKoW7z18h
         iybXyB0UHw74w/vrG0Qi0ZFq5Nh0xOFPlr0V5es3NxgOIpFjMAm+kll70q8lLjbih3S5
         2Bpy76lN41igs3xo6ag+2qGpips4xI280MyXdPnTVb/McppORjuyrW+J8Dz8vb3Upndz
         O6v+fbCQlhRcyBvs30dIh68mWIzfBHyh+WBhhCPxeoD2puGbnFhfJdB4Iz1Qnm9JQRBd
         eY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lnCPkOcNS67xMF6t5lbmMUCC2k2JGvmiyTaTvXGTcLg=;
        b=EtGod+CnAxElWc0FPN+HeLomO2CV4EiRp8ja8tw8FvyVVI79xO1XBTUMAj2cSSFjv8
         iUz2r+7Xufd1MUN0XD18rGUWsTaEiH+A+vdiDQ0BXFbKyM26CSnb1AVK1Pn3Rew9pLrX
         LDjlqVyuWQ++7IpUnIULEGmofUVjcwy/SYZGEqY7J5dp7e2vPgbT6Nx32Wh30ppEbCnp
         uLQY6dTcl3dMdH5zt6/G7v4NHQUciLmNXqdPZtMBoFjdq3oPT4ts/SE/vyd4JXiFAsc/
         PYHMd2mZkgXsLp8BRo1zCP15js3RCcgW+oUjav1f/Z60pOGMU6DA4/nS3SjP+JVnfLm5
         A+Bw==
X-Gm-Message-State: AOAM530HG0ZhNm7icXVPXQX3A0XJiPEFgqVtkMosRRbSdujwUMP+asGW
        ypiLhBvuVCXTYzjASfs1Vps=
X-Google-Smtp-Source: ABdhPJx3gibPeJlUU0ezZ7gBsVLu8HUUp+pNM4aa/k2HYCxOmD8uJA9mLLmm2zDTZCHnV+X7xRGqkQ==
X-Received: by 2002:a17:906:3c46:: with SMTP id i6mr1905067ejg.66.1594808508292;
        Wed, 15 Jul 2020 03:21:48 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:5cd9:fc:d7bc:c84f])
        by smtp.gmail.com with ESMTPSA id b14sm1621987ejg.18.2020.07.15.03.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 03:21:47 -0700 (PDT)
Date:   Wed, 15 Jul 2020 12:21:46 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Edward Cree <ecree@solarflare.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        kbuild-all@lists.01.org, linux-renesas-soc@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [renesas-drivers:master 69/80]
 drivers/net/ethernet/sfc/efx_common.c:1232:19: sparse: sparse: incompatible
 types for operation (==):
Message-ID: <20200715102146.7b2nac2x4itsewma@ltop.local>
References: <202007150206.kfukZxuy%lkp@intel.com>
 <20200714185622.GA408711@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714185622.GA408711@bjorn-Precision-5520>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 14, 2020 at 01:56:22PM -0500, Bjorn Helgaas wrote:
> [+cc Luc, linux-pci]

Bjorn,

What do you thnk about restoring 'enum pci_channel_state state' for one
kernel cycle? Retrospectively, I think it was a bad idea to remove it
directly.

-- Luc 
