Return-Path: <linux-pci+bounces-28170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C11ABE82E
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 01:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E28417B1DE0
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 23:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E880A25C818;
	Tue, 20 May 2025 23:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wcVnZiJ4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B88256C7D
	for <linux-pci@vger.kernel.org>; Tue, 20 May 2025 23:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747784425; cv=none; b=ZVnj+6AqJzZKVRYPC/3vC/hyFm7ik7QV2OA7qnw67YkY3F795a1BoPValH6tr7RRGDM1v30i3hVwlWiUaIOm8O6S3sCJuJuQ+R8AL2xni5cxmnh90iHEZQStptde4KDanQ4VVX9gAGeB7rKhd0MAfqhHgi8TpzHzeK+CTHpyzqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747784425; c=relaxed/simple;
	bh=SX+UcDxDxooKe46ZCkztzQdf9ywTt+hzpPqr+Dk9CiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9/p6jFlt18SGGEebEWzB9CMh/689IO4yQI4uG39eKwc5VGtGPN1G4oNh8Lg+LJB09LhtFqiRpUBx9B59haG5Ug/aNRlMdNshj68ItBmWOV+dwP9BGjZjX7ltbqlnW+GVTQmUuFAo3DTyFEuWeuzwOTKnCL0fIOYhkvwuVJSMx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wcVnZiJ4; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b0b2d0b2843so4721840a12.2
        for <linux-pci@vger.kernel.org>; Tue, 20 May 2025 16:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747784423; x=1748389223; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aqZ+48uzoG4Laks60UH8Pr7nDATfOwjlEAjIjwnXH8g=;
        b=wcVnZiJ4r/NnICLqXqcVeY/f9/oIuq1lonQczmUT2jo582z4W3le5f4Ynrkwi5SNh7
         o393pbCqei+Vdqb9LldOO4h5K5muzn+wXp1AyN6fsN5E6uhANKAp3kA6ZA9bwV1N2uUD
         creq+42b0XM/eaA/3+ZeuDbRkW5FiX19OQY+BLurqZMlFZHldD5JRGYy4ImI2ehT7WsD
         KQZZsyHzZow9nwBXqZNAkkxpQjF9aKZT5L3vhaT/pC9TVFIn8EsOFE9blW7/ZKriV62j
         v/6WUfT1nuEUtD3VndTAwxiWordBrqZdt0OrsxWjvbBvNnvWBEwEmteUzCCR1uvBV4Nw
         yReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747784423; x=1748389223;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqZ+48uzoG4Laks60UH8Pr7nDATfOwjlEAjIjwnXH8g=;
        b=ecQqYbjbpJh1rLLSK00S+Ll0TODCKELrbsHXZxdfowav8FgOmUui+MF+GQN9tRWmyH
         3A4/15fuWeJfrKBQMJ1SB7kLBHep3fisrxEyCi3wPid/py+8IwWcubhw4p1TfD5fUfj1
         CaKmSZWvaGeD6cCiGokuZIbD2BvZ9tItqcjUqYfFdIms5FxQSrjolgO4mv6L6hWAHdm5
         3WBcOk9l8xFNQ8rQH/RzhUAX2CghaaVXxMt7pv3uSdjEBFCz70whKhoEGCn1E6sD6VXK
         UbisTN6CNrdX8E2vQt0Xu9+LSttZ1YAt0v25N9REcw9X02AC+J38AbUJZeac2WMH0yCy
         JSIg==
X-Forwarded-Encrypted: i=1; AJvYcCUmhyX91lF+xhx6fYDqHv+89yQt7PHl1sFFggHXPVuGspdEHo6ntn3t3aunp/BuLIDtT6GRv0OHJW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOSg4RrEKbnagSMUAs6dzDagRp2/TbVwFAAqd03Qid0Q5OkkOT
	m+p29u6kC3Y7QfTvJACzgxmNsAqSuyXOGkyWNhV9F8n5warhrMd8TZgzLtsud4ou6Q==
X-Gm-Gg: ASbGncs9B2Z36Qed4z6ZYPDc1vNoP+K/RNuVtLu2JXgka+ZsVvkNvW/mDBTN1mfpibI
	lvrer7NN6mXgV9LImrAjGviFzdhppTQWrfEFhrQueQmfypl0L/FS3WSKWuYkY7KWVAReXEbshju
	kgD5uc6TS7MX8KqV5ayuS85ixNzVDSb6uKdxX1uzAJjWVvo8Pq3mNoCUktC0Tqn5SWOAMXclrBe
	EkCEoJcFUszLw5ooDV04MiGir+N5Ic1vE317tnceabs59jr/DQaqbOpQ6otW2OzrKTYRZGm8H29
	QasZwdkM1XzmPHkV/aAE4tBUPU3Mmi8wqXHiwISxJKULrYUkq3JKLH+aB6nv4qF8RVtcGqTlKw=
	=
X-Google-Smtp-Source: AGHT+IGLOF8Oz3iIbi7z+4PFDCTgEXwLx/JfBFJ7u4aeO1DNr49AGrVsutLPXjUIBAZ305Cg4SHFrQ==
X-Received: by 2002:a05:6a21:33a5:b0:1f5:87ea:2a10 with SMTP id adf61e73a8af0-216218827c2mr25840743637.9.1747784423382;
        Tue, 20 May 2025 16:40:23 -0700 (PDT)
Received: from thinkpad ([103.241.193.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98a3380sm8701239b3a.170.2025.05.20.16.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 16:40:22 -0700 (PDT)
Date: Wed, 21 May 2025 00:40:18 +0100
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 'Cyril Brulebois <kibi@debian.org>, 
	"maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>, 'Nicolas Saenz Julienne <nsaenz@kernel.org>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: POSSIBLE REGRESSION: PCI/pwrctrl: Skip scanning for the device
 further if pwrctrl device is created
Message-ID: <uye7kpakmj5vx6bdzzy4tsmqqi777rhdb273tqsvgr6tv27apy@jyneanv3blit>
References: <CA+-6iNxkYumAvk5G6KhYqON9K3bwxGn+My-22KZnGF5Pg8cgfA@mail.gmail.com>
 <20250519215601.GA1258127@bhelgaas>
 <CA+-6iNzY4n=E+4Fcbxu7UU+xyUjEQZBSLQ3sMv26smoFS+nGOA@mail.gmail.com>
 <pxscvlfsvzaatjwty3bt3lpjmhhq4hriwmqo2s4vycwb27uvpq@m3afnghha5dd>
 <CA+-6iNz-qyKDKif5mv5FProqbpkQdfOYx+nSUA4NHSiCL9Ng5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNz-qyKDKif5mv5FProqbpkQdfOYx+nSUA4NHSiCL9Ng5Q@mail.gmail.com>

On Tue, May 20, 2025 at 11:06:33AM -0400, Jim Quinlan wrote:

[...]

> > > > What systems does the regression affect?
> > >
> > > All Broadcom STB chips, including the RPi sister chips.  Now is there
> > > anyone but our team who runs upstream Linux on our boards?  Probably
> > > not.
> > >
> >
> > I forgot to ask you this question. Is your devicetree upstreamed? Because, while
> > introducing the pwrctrl knobs, I made sure that there are no upstream users
> > using the supply properties in child nodes. All our existing users are using the
> > properties in controller nodes, so they are not impacted.
> Hello Mani,
> 
> Our device tree is constructed on the fly by our custom bootloader
> and passed to Linux, so it does not make sense (IMO) to put them
> upstream as long as we strictly follow our upstreamed YAML bindings
> file.  As I mentioned before, our  brcm,stb-pcie.yaml example, which
> is upstream, contains a "vpcie3v3-supply" property under the pci@0,0
> node.
> 

Okay, thanks for the pointer. I was not aware that you have bootloader
constructed DTB.

> >
> > Here it looks like you are running out-of-tree dts, which we do not support
> > unfortunately.
> The brcmstb YAML file is upstream, and a grep for the standard pcie
> regulator names would have led you to it. I don't see how you can say
> you don't support a DT that follows the upstream YAML file(s).
> 

I didn't say that exactly. I thought you were using some out-of-tree vendor DTS
which doesn't adhere to the DT bindings, but I was wrong. Your usecase is
completely valid.

> But it doesn't mean that I do not care about the issue you
> > reported. I'm flying back home from vacation tomorrow and it will be the first
> > thing I'm goona look into.
> >
> > Adding suspend/resume support is pretty much what I'm going to work on the
> > upcoming weeks (combined with some rework). So until then, I request you to
> > revert the changes in your downstream tree and bear with me.
> 
> I would rather our systems peacefully coexist, and take your changes
> voluntarily and on my own schedule, rather than wait for you to add
> future features.  I'm a little surprised that the CONFIG_PCI_PWRCTL
> code seems to act on the PCI regulators even when its driver is not
> present.
> 

I overlooked at that part. Would the below diff help you?

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4b8693ec9e4c..b38a62f40448 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2514,6 +2514,9 @@ static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, in
        struct platform_device *pdev;
        struct device_node *np;
 
+       if (!IS_ENABLED(CONFIG_PCI_PWRCTRL))
+               return NULL;
+
        np = of_pci_find_child_device(dev_of_node(&bus->dev), devfn);
        if (!np || of_find_device_by_node(np))
                return NULL;


> In addition, I need the ability to cancel at runtime the
> suspend/resume off/on of the regulators if the downstream device.
> 

I don't get what you mean by 'ability to cancel at runtime'. Like I said before,
I'm going to rework pwrctrl little bit and probably add suspend/resume (system
PM first) on the way, if that's what you are referring to.

> That being said,  I don't mind if the series stays as long as you
> promise to work with me to have our systems coexist.  But I do not
> want to wait for future features to be added for our code to work.
> >
> > Bjorn, FYI: We do not need any revert in mainline since the issue is not
> > affecting upstream users.
> 
> So is it a rule that all DT  must be upstreamed, or is it sufficient
> to have a bindings YAML file that defines the DT for the driver?
> 

The latter IMO. If the diff I supplied above works fine, I'll submit a patch for
that. Eventually, we do like to control the supplies from the pwrctrl driver
instead of from controller drivers. That's the whole point of introducing this
framework. But since it is not enabled in defconfig yet, your driver should
continue working in the meantime with the diff. Later on, I will modify brcmstb
driver to adapt to pwrctrl framework. Since the binding is same, the driver is
going to be backwards compatible also.

Please let me know if it works of not!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

