Return-Path: <linux-pci+bounces-45081-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA2AD38B21
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jan 2026 02:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67DD1302AFD6
	for <lists+linux-pci@lfdr.de>; Sat, 17 Jan 2026 01:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E932120296E;
	Sat, 17 Jan 2026 01:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H7R8CdcA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407F314D29B
	for <linux-pci@vger.kernel.org>; Sat, 17 Jan 2026 01:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768612747; cv=none; b=TWpsl7i4lNK6KRSdaQ73t35WIvXF5GJzanNe8ki2Dsrn/KVhkfn+pNwaQp2Jmqw7+iqz9E0lnbFR+w52aszJ3B9K+BY9ETrc2tavtZiJV2+Ih3omTUOXq4vVqIIyhuqd9B8cjXymQmJxK1EBuP2R2lMgmcb5iwhaYc2VFshdYUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768612747; c=relaxed/simple;
	bh=oiXaqMYODjg1arBEE6sv9z3qo3UTU4gKYzpVzbvdyWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QE2bCaZGoqOFjcs9wvSGHYE3Hn2OktUloLuoEEOfDzSR/Z96wXa6g1wanvv6J4nciVgCxohWV7h8KoYHSplzShc3e3OZIc9KVUJntVb9N/RRkdgPPO99qs+r+enrHwYXVOle+1l753fzBNHnKF64dRuQsKUtzAh5yYc+nwLwxQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H7R8CdcA; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-121bf277922so3590658c88.0
        for <linux-pci@vger.kernel.org>; Fri, 16 Jan 2026 17:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1768612745; x=1769217545; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bUSfdigo0QegF95c0ywdbi1fN/IvZ4l9pVY9Jz84g3A=;
        b=H7R8CdcAQAKRqWa57K4xjxrte9kmjqlXAu5TJeqqsCIJYJUcmD2eGa7a6BghSBsBlQ
         0j5rWvgVkBVQKpIKqeaxf8QHTl2L8v7CRzRBCFehfvpNrKEe5LIuYVGMRFGWskqU5q55
         JMnca699A4E2Dy/7s0GGUAKSMA22Gj1l/j8OY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768612745; x=1769217545;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bUSfdigo0QegF95c0ywdbi1fN/IvZ4l9pVY9Jz84g3A=;
        b=NTXy8xQ3XaX6ZxZ4xjKRJlfW8bNw4Nm+z4qO4OR4KH17/CptKjIgMokMYAuY4rrgas
         K/vxmNiAyWRLt4TwUrqlZqrCC8RiK44i5a+HzxP/bgbTXgSInLKcO2cYkEYl+qapJbwD
         gmWEsxDHavGPBcdrRgQimMGwibzt5OVeFXqUxifMx2kAOJmOOzNlDqeH++HuBsn8m+ot
         fkpvXfC/IL03B5FkdO5yoPNE+F+0Sa0S5kx6r3Hu6kqOBoPE015uVhONU129N5x1tZI3
         YYlpc2aFe6tTdmIvkAH+oDOtaoITOiApnTf+7zCcuUGzL4bdq6Z2/Z/a3JR8opSXuZLZ
         N8WQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5Zx7Vn/s/sLjdtXb+lfOqB8ZPjqA+en9EMugAssKVx2xwGK/vUGExHbQIjXtbi+gFv1l4GYobvE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAcuKRd+GGaNdJM0SX2mfSsbU8jC6+OojNZrnD3H+pZsfMKT9g
	07vXwNT2IAzPW9ZuTRk2Brfuz+Hcl5SR9nghE11FN+ylpvoMtV0u3gKljTDJARHyzA==
X-Gm-Gg: AY/fxX4nzZr9XJSlkPs01LB59FDUvelOuzf0Ab4EocxYtvtQcJkkkbGhY0O5gBXO9QW
	WY03AnvUfp9dV8wvJGw2gCH9uWOCibzt1MOlADgAHlafdbzBpQQTFjQVkiGdm0LQaO5fdgah5LT
	L2i+tG948TT4vRn1RBKn2trRlu3IH5E8xvaAhZMPCexyybx+hr8M3IyZBKO5JtFYDIPiea78Im9
	eGFSNhZU6c/ON1kK1igNq3EeO5p0M351Y+i6qv/MUjYGzjbyCEgEp3nQp/jWT2ldRu6VIUqGzNg
	aMjGMdSasftBrQW00uaTKlLVJdZzWK/JdtzJbDPsggKySurRVKwHg4Rp9sBArcAdVO+XOxwPTVc
	d5OOGWYxyzT3lEg4syrfNkkRDKf/jD3p/EYXZsSmfHCY13mtIKvJu5BzUIh65/tBXIkGYrUgpE9
	SbgvCZBdIY8DtJ/MRnY4Emsalj4L/4/pB8uGscGPvX/SXlZNTN
X-Received: by 2002:a05:7022:6707:b0:123:3407:106d with SMTP id a92af1059eb24-1244b35a557mr3491117c88.28.1768612745208;
        Fri, 16 Jan 2026 17:19:05 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:4a2:a8d7:4949:d44a])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1244ad740c5sm5489508c88.8.2026.01.16.17.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 17:19:04 -0800 (PST)
Date: Fri, 16 Jan 2026 17:19:02 -0800
From: Brian Norris <briannorris@chromium.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v4] PCI/PM: Prevent runtime suspend before devices are
 fully initialized
Message-ID: <aWrjhqC_6I2UNXC5@google.com>
References: <20260106222715.GA381397@bhelgaas>
 <CGME20260114094643eucas1p1a2fdc6c35dd27741c18831b34bbed0c8@eucas1p1.samsung.com>
 <0e35a4e1-894a-47c1-9528-fc5ffbafd9e2@samsung.com>
 <aWf4KyTSIocWTmXw@google.com>
 <61e8c93c-d096-4807-b2dd-a22657f2e06a@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61e8c93c-d096-4807-b2dd-a22657f2e06a@samsung.com>

Hi Marek,

On Thu, Jan 15, 2026 at 12:14:49PM +0100, Marek Szyprowski wrote:
> On 14.01.2026 21:10, Brian Norris wrote:
> > On Wed, Jan 14, 2026 at 10:46:41AM +0100, Marek Szyprowski wrote:
> >> On 06.01.2026 23:27, Bjorn Helgaas wrote:
> >>> On Thu, Oct 23, 2025 at 02:09:01PM -0700, Brian Norris wrote:
> >>>> Today, it's possible for a PCI device to be created and
> >>>> runtime-suspended before it is fully initialized. When that happens, the
> >>>> device will remain in D0, but the suspend process may save an
> >>>> intermediate version of that device's state -- for example, without
> >>>> appropriate BAR configuration. When the device later resumes, we'll
> >>>> restore invalid PCI state and the device may not function.
> >>>>
> >>>> Prevent runtime suspend for PCI devices by deferring pm_runtime_enable()
> >>>> until we've fully initialized the device.
> > ...
> >> This patch landed recently in linux-next as commit c796513dc54e
> >> ("PCI/PM: Prevent runtime suspend until devices are fully initialized").
> >> In my tests I found that it sometimes causes the "pci 0000:01:00.0:
> >> runtime PM trying to activate child device 0000:01:00.0 but parent
> >> (0000:00:00.0) is not active" warning on Qualcomm Robotics RB5 board
> >> (arch/arm64/boot/dts/qcom/qrb5165-rb5.dts). This in turn causes a
> >> lockdep warning about console lock, but this is just a consequence of
> >> the runtime pm warning. Reverting $subject patch on top of current
> >> linux-next hides this warning.
> >>
> >> Here is a kernel log:
> >>
> >> pci 0000:01:00.0: [17cb:1101] type 00 class 0xff0000 PCIe Endpoint
> >> pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x000fffff 64bit]
> >> pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
> >> pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 5.0
> >> GT/s PCIe x1 link at 0000:00:00.0 (capable of 7.876 Gb/s with 8.0 GT/s
> >> PCIe x1 link)
> >> pci 0000:01:00.0: Adding to iommu group 13
> >> pci 0000:01:00.0: ASPM: default states L0s L1
> >> pcieport 0000:00:00.0: bridge window [mem 0x60400000-0x604fffff]: assigned
> >> pci 0000:01:00.0: BAR 0 [mem 0x60400000-0x604fffff 64bit]: assigned
> >> pci 0000:01:00.0: runtime PM trying to activate child device
> >> 0000:01:00.0 but parent (0000:00:00.0) is not active
> > Thanks for the report. I'll try to look at reproducing this, or at least
> > getting a better mental model of exactly why this might fail (or,
> > "warn") this way. But if you have the time and desire to try things out
> > for me, can you give v1 a try?
> >
> > https://lore.kernel.org/all/20251016155335.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/
> >
> > I'm pretty sure it would not invoke the same problem.
> 
> Right, this one works fine.
> 
> > I also suspect v3
> > might not, but I'm less sure:
> >
> > https://lore.kernel.org/all/20251022141434.v3.1.I60a53c170a8596661883bd2b4ef475155c7aa72b@changeid/
> This one too, at least I was not able to reproduce any fail.

Thanks for testing. I'm still not sure exactly how to reproduce your
failure, but it seems as if the root port is being allowed to suspend
before the endpoint is added to the system, and it remains so while the
endpoint is about to probe. device_initial_probe() will be OK with
respect to PM, since it will wake up the port if needed. But this
particular code is not OK, since it doesn't ensure the parent device is
active while preparing the endpoint power state.

I suppose one way to "solve" that is (untested):

--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -380,8 +380,12 @@ void pci_bus_add_device(struct pci_dev *dev)
 		put_device(&pdev->dev);
 	}
 
+	if (dev->dev.parent)
+		pm_runtime_get_sync(dev->dev.parent);
 	pm_runtime_set_active(&dev->dev);
 	pm_runtime_enable(&dev->dev);
+	if (dev->dev.parent)
+		pm_runtime_put(dev->dev.parent);
 
 	if (!dn || of_device_is_available(dn))
 		pci_dev_allow_binding(dev);

Personally, I'm more inclined to go back to v1, since it prepares the
runtime PM status when the device is first discovered. That way, its
ancestors are still active, avoiding these sorts of problems. I'm
frankly not sure of all the reasons Rafael recommended I make the
v1->v3->v4 changes, and now that they cause problems, I'm inclined to
question them again.

Rafael, do you have any thoughts?

Brian

