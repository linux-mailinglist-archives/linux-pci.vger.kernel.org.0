Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B963B3294
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 17:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbhFXPad (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 11:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbhFXPac (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jun 2021 11:30:32 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48ECC061574;
        Thu, 24 Jun 2021 08:28:12 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id g192so5456381pfb.6;
        Thu, 24 Jun 2021 08:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q2gPlbxZIu0s2pp6ayJgQnoK8WTCgbC9z/0R22rI7LA=;
        b=hQX23N294SlJ3Va9DqB9y9whZlmWswxGS0Zaj1oObBt2Y9ymGHliiplpfi3/NRXbWz
         Z7ef0HCQZOY4/7YhyTc5nECnIjsIm2Y159MvDm/u5VeUKW39c0CXfvFW9lqLyZa1aF0l
         lWeLAH+VXY+vTEIaqiIgrgxwUubLRPlMT7w/LXdFLUX7UuxOcRu7dTIIA/X0Q3YtqEY6
         pJP0ox++dod96lJvzInz2A2TMQTDFY/EXA6zTChEU4pOpRCcdiez8zDN32vLbPaSLEGq
         BgLCvLJo4tzt8wLVZQDu6aIbQQeWpu7S2Ajet3jez2VVRhi26k9Rc/89jZhPG7pEi2NY
         kmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q2gPlbxZIu0s2pp6ayJgQnoK8WTCgbC9z/0R22rI7LA=;
        b=bXQKlQuDtD65pv5KuP7c8m1mBlpjhvJiq653yHbfxewkFv5V1bxNdRkR5YcHpJGKqL
         A2srGWmXTfGUMLdcusnG9h/V9UzrYL4uVNAsImGJeehTNsexrWlMspiX/rXrCSRTZM1X
         /muvWAgvwZNInXyXvD+Y2F6K4mD65cDOytjYTty9R8rAlwYu9Eg1la27pV6B7UUH7JEc
         yjGnqY4BL2cxI3y5Gt7cWP/dv4G9E6sh2C2h97KtbmpLUAeH1rhwHCAEYTAr/e+DQQuX
         yoc8yR2V6XxOHVpPZf7axxLroQ2Iyxd3CpYZGjng4jMS2GbocaN3VnbI/wPlXIz9cGCl
         lbKA==
X-Gm-Message-State: AOAM533jOhjx5wpiA28F1aiVPmKBVZ6W7A+mReORp9yd1BdkTlv6epvw
        VpiFiUkv7iblM0Qqo0ZAngU=
X-Google-Smtp-Source: ABdhPJwmceMxhr6RsXl0aCSiYeaB/BVCTVe5LMoG0ibCbU1T+OhWgLWjJ/ZDfa6Y1tJIrSxHkwAAoQ==
X-Received: by 2002:a63:7985:: with SMTP id u127mr5259787pgc.228.1624548492228;
        Thu, 24 Jun 2021 08:28:12 -0700 (PDT)
Received: from localhost ([103.248.31.165])
        by smtp.gmail.com with ESMTPSA id v13sm3669552pja.44.2021.06.24.08.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 08:28:11 -0700 (PDT)
Date:   Thu, 24 Jun 2021 20:58:09 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 1/8] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
Message-ID: <20210624152809.m3glwh6lxckykt33@archlinux>
References: <20210608054857.18963-2-ameynarkhede03@gmail.com>
 <20210624122309.GA3518896@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624122309.GA3518896@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/06/24 07:23AM, Bjorn Helgaas wrote:
> On Tue, Jun 08, 2021 at 11:18:50AM +0530, Amey Narkhede wrote:
> > Currently there is separate function pcie_has_flr() to probe if pcie flr is
> > supported by the device which does not match the calling convention
> > followed by reset methods which use second function argument to decide
> > whether to probe or not.  Add new function pcie_reset_flr() that follows
> > the calling convention of reset methods.
>
> > +/**
> > + * pcie_reset_flr - initiate a PCIe function level reset
> > + * @dev: device to reset
> > + * @probe: If set, only check if the device can be reset this way.
> > + *
> > + * Initiate a function level reset on @dev.
> > + */
> > +int pcie_reset_flr(struct pci_dev *dev, int probe)
> > +{
> > +	u32 cap;
> > +
> > +	if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
> > +		return -ENOTTY;
> > +
> > +	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
> > +	if (!(cap & PCI_EXP_DEVCAP_FLR))
> > +		return -ENOTTY;
> > +
> > +	if (probe)
> > +		return 0;
> > +
> > +	return pcie_flr(dev);
> > +}
>
> Tangent: I've been told before, but I can't remember why we need the
> "probe" interface.  Since we're looking at this area again, can we add
> a comment to clarify this?
>
> Every time I read this, I wonder why we can't just get rid of the
> probe and attempt a reset.  If it fails because it's not supported, we
> could just try the next one in the list.

Part of the reason is to have same calling convention as other reset
methods and other reason is devices that run in VMs where various
capabilities can be hidden or have quirks for avoiding known troublesome
combination of device features as Alex explained here
https://lore.kernel.org/linux-pci/20210624151242.ybew2z5rseuusj7v@archlinux/T/#mb67c09a2ce08ce4787652e4c0e7b9e5adf1df57a

On the side note as you suggested earlier to cache flr capability
earlier the PCI_EXP_DEVCAP reading code won't be there in next version
so its just trivial check(dev->has_flr).

Thanks,
Amey
