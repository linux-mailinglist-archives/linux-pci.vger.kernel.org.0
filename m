Return-Path: <linux-pci+bounces-8485-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE93D900D1D
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 22:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 203EAB22C9B
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 20:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7762814373C;
	Fri,  7 Jun 2024 20:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WI7uTdHj"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649AA1411F1
	for <linux-pci@vger.kernel.org>; Fri,  7 Jun 2024 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717793074; cv=none; b=n7+qQYvtKHnLusTYo6KREFZvnHyKS5ceHB1asF7sPGx+YIK4tACaoW+xRUszWxqv58zN9t16YzO5XHa9fmcQ4/PV5PV0d1cLxGNHMWu78Qg8BDEm7Sb7SlEzmRow6auoggWdS9rI2P24hu60qx/oTxgQDKL84MMuCWJnG7Adgi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717793074; c=relaxed/simple;
	bh=L5DP6ctDhQUsA/qoa9qOLqxlcRsf3EE4G8oaRWuRdfc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gmczi2NujrciFGNBBw+p6IelbS76jYcqBl976i0mAbs2f0EaXAtQFSo+qBrYqeOyNno+0FDLutia99vFlqbR60dLZBLnv+4jMH+9IFXBNK9ASUaaYvIwVNaaqrjek/HcB0QicFmqIAKIGdOa4DCMBI13KQyjOR3alUf3TgOXfIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WI7uTdHj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717793071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tqJs0lOyJZJnAr3j3IhuY+Y1uSQ1pJxmvCGi7gWbLjA=;
	b=WI7uTdHjo2GZo7Upho9Cg0HIPf5IWT0eFDoxk6ED7I0wQIhIeAG5pbtrrdQIkSYrTtS0Cl
	TlWPoz1UKOxCk9FMMExBNZ1Ud8BsUR6hp2D+HQ85eY1wEx0f9pE9X1GRvaE4oDUEBPps+b
	wiacn1TU7NBRYULDZ9Ya8JW9uDjek4U=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-BHZ3Q8LfPvWGDs3r_lgIzw-1; Fri, 07 Jun 2024 16:44:29 -0400
X-MC-Unique: BHZ3Q8LfPvWGDs3r_lgIzw-1
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6f965175208so524826a34.1
        for <linux-pci@vger.kernel.org>; Fri, 07 Jun 2024 13:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717793069; x=1718397869;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tqJs0lOyJZJnAr3j3IhuY+Y1uSQ1pJxmvCGi7gWbLjA=;
        b=QmL+oZbAecZI5l2XaH2oGHB5zmWuH6PCbAaIJ6fG+2l1sbQZDwWWIlFTFvu9WnD6c1
         gid8ltSuSRgK/sWXVLQlSltIUKKBVl8B7RjovCnTkgnvmHgq7X0c41foVeMZDrOEYQTF
         yD7eVkqs2BleCmvyKxOh1LPwEPvbndjn+RSjRDH/GVSRbF2eu3aaieKfpjte5/z5QW8g
         TZNdRBctwcKk308Bvdm8ffyBjyWsQ5DzfETupWiyOf/5XwnwBsfOG3oGWKQnAlgD2JLN
         xRrtlTJ0vXd3a1OFAfaLA3hYSoKOIYcuJVlfPVJHgJaTgUjwiyy/Mn1xBD2c/Mf2WYx2
         1Ang==
X-Forwarded-Encrypted: i=1; AJvYcCXSLZ1At0wLQm/Gzdc75BHOiv5wthEdw6pzprV4I6TzTXC+ZBRjEGBdaAH5vVc+N3SBhHxoPHQlaBc48GauIeH6NbLDGk08sQSp
X-Gm-Message-State: AOJu0YybBI/56YR/ASyqA4PFW2VZxQ+ZKkFf8RMSIeZeIh5Vns/uDhUh
	GE+Tfy8duyqxkyn2JjJph6/xhCyQ9+dIa7fPCpLDlS+wbl/mkNdy1XFC/u0ogzwrLJKU0Q2c30E
	bmbvgc5/GAanpgO5Yl5tyVU7cR5TnTMVreR9uMj0JYqGOOHlsWfVWYtuUVw==
X-Received: by 2002:a05:6830:1bd6:b0:6f0:e55b:132 with SMTP id 46e09a7af769-6f957304a6amr3505046a34.29.1717793068821;
        Fri, 07 Jun 2024 13:44:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkSQe0f61Gb/qi9uc4f5Bkao6z9EV8gWNpIRbd/RPdksTnFIbZcIPphY/TvdkcZWrNxb0Q/Q==
X-Received: by 2002:a05:6830:1bd6:b0:6f0:e55b:132 with SMTP id 46e09a7af769-6f957304a6amr3505023a34.29.1717793068369;
        Fri, 07 Jun 2024 13:44:28 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f94dc9de04sm827696a34.39.2024.06.07.13.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 13:44:27 -0700 (PDT)
Date: Fri, 7 Jun 2024 14:44:26 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: bhelgaas@google.com, linux-pci@vger.kernel.org
Cc: geoff@hostfission.com, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH] PCI: Release unused bridge resources during resize
Message-ID: <20240607144426.72d9a662.alex.williamson@redhat.com>
In-Reply-To: <20240507213125.804474-1-alex.williamson@redhat.com>
References: <20240507213125.804474-1-alex.williamson@redhat.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Ping.  Any further thoughts on this approach or suggestions for
something different?  Thanks,

Alex

On Tue,  7 May 2024 15:31:23 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> Resizing BARs can be blocked when a device in the bridge hierarchy
> itself consumes resources from the resized range.  This scenario is
> common with Intel Arc DG2 GPUs where the following is a typical
> topology:
> 
>  +-[0000:5d]-+-00.0-[5e-61]----00.0-[5f-61]--+-01.0-[60]----00.0  Intel Corporation DG2 [Arc A380]
>                                              \-04.0-[61]----00.0  Intel Corporation DG2 Audio Controller
> 
> Here the system BIOS has provided a large 64bit, prefetchable window:
> 
> pci_bus 0000:5d: root bus resource [mem 0xb000000000-0xbfffffffff window]
> 
> But only a small portion is programmed into the root port aperture:
> 
> pci 0000:5d:00.0:   bridge window [mem 0xbfe0000000-0xbff07fffff 64bit pref]
> 
> The upstream port then provides the following aperture:
> 
> pci 0000:5e:00.0:   bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]
> 
> With the missing range found to be consumed by the switch port itself:
> 
> pci 0000:5e:00.0: BAR 0 [mem 0xbff0000000-0xbff07fffff 64bit pref]
> 
> The downstream port above the GPU provides the same aperture as upstream:
> 
> pci 0000:5f:01.0:   bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]
> 
> Which is entirely consumed by the GPU:
> 
> pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]
> 
> In summary, iomem reports the following:
> 
> b000000000-bfffffffff : PCI Bus 0000:5d
>   bfe0000000-bff07fffff : PCI Bus 0000:5e
>     bfe0000000-bfefffffff : PCI Bus 0000:5f
>       bfe0000000-bfefffffff : PCI Bus 0000:60
>         bfe0000000-bfefffffff : 0000:60:00.0
>     bff0000000-bff07fffff : 0000:5e:00.0
> 
> The GPU at 0000:60:00.0 supports a Resizable BAR:
> 
> 	Capabilities: [420 v1] Physical Resizable BAR
> 		BAR 2: current size: 256MB, supported: 256MB 512MB 1GB 2GB 4GB 8GB
> 
> However when attempting a resize we get -ENOSPC:
> 
> pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
> pcieport 0000:5f:01.0: bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
> pcieport 0000:5e:00.0: bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
> pcieport 0000:5e:00.0: bridge window [mem size 0x200000000 64bit pref]: can't assign; no space
> pcieport 0000:5e:00.0: bridge window [mem size 0x200000000 64bit pref]: failed to assign
> pcieport 0000:5f:01.0: bridge window [mem size 0x200000000 64bit pref]: can't assign; no space
> pcieport 0000:5f:01.0: bridge window [mem size 0x200000000 64bit pref]: failed to assign
> pci 0000:60:00.0: BAR 2 [mem size 0x200000000 64bit pref]: can't assign; no space
> pci 0000:60:00.0: BAR 2 [mem size 0x200000000 64bit pref]: failed to assign
> pcieport 0000:5d:00.0: PCI bridge to [bus 5e-61]
> pcieport 0000:5d:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> pcieport 0000:5d:00.0:   bridge window [mem 0xbfe0000000-0xbff07fffff 64bit pref]
> pcieport 0000:5e:00.0: PCI bridge to [bus 5f-61]
> pcieport 0000:5e:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> pcieport 0000:5e:00.0:   bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]
> pcieport 0000:5f:01.0: PCI bridge to [bus 60]
> pcieport 0000:5f:01.0:   bridge window [mem 0xb9000000-0xb9ffffff]
> pcieport 0000:5f:01.0:   bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]
> pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]: assigned
> 
> In this example we need to resize all the way up to the root port
> aperture, but we refuse to change the root port aperture while resources
> are allocated for the upstream port BAR.
> 
> The solution proposed here builds on the idea in commit 91fa127794ac
> ("PCI: Expose PCIe Resizable BAR support via sysfs") where the BAR can
> be resized while there is no driver attached.  In this case, when there
> is no driver bound to the upstream switch port we'll release resources
> of the bridge which match the reallocation.  Therefore we can achieve
> the below successful resize operation by unbinding 0000:5e:00.0 from the
> pcieport driver before invoking the resource2_resize interface on the
> GPU at 0000:60:00.0.
> 
> pci 0000:60:00.0: BAR 2 [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
> pcieport 0000:5f:01.0: bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
> pci 0000:5e:00.0: bridge window [mem 0xbfe0000000-0xbfefffffff 64bit pref]: releasing
> pci 0000:5e:00.0: BAR 0 [mem 0xbff0000000-0xbff07fffff 64bit pref]: releasing
> pcieport 0000:5d:00.0: bridge window [mem 0xbfe0000000-0xbff07fffff 64bit pref]: releasing
> pcieport 0000:5d:00.0: bridge window [mem 0xb000000000-0xb2ffffffff 64bit pref]: assigned
> pci 0000:5e:00.0: bridge window [mem 0xb000000000-0xb1ffffffff 64bit pref]: assigned
> pci 0000:5e:00.0: BAR 0 [mem 0xb200000000-0xb2007fffff 64bit pref]: assigned
> pcieport 0000:5f:01.0: bridge window [mem 0xb000000000-0xb1ffffffff 64bit pref]: assigned
> pci 0000:60:00.0: BAR 2 [mem 0xb000000000-0xb1ffffffff 64bit pref]: assigned
> pci 0000:5e:00.0: PCI bridge to [bus 5f-61]
> pci 0000:5e:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> pci 0000:5e:00.0:   bridge window [mem 0xb000000000-0xb1ffffffff 64bit pref]
> pcieport 0000:5d:00.0: PCI bridge to [bus 5e-61]
> pcieport 0000:5d:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> pcieport 0000:5d:00.0:   bridge window [mem 0xb000000000-0xb2ffffffff 64bit pref]
> pci 0000:5e:00.0: PCI bridge to [bus 5f-61]
> pci 0000:5e:00.0:   bridge window [mem 0xb9000000-0xba0fffff]
> pci 0000:5e:00.0:   bridge window [mem 0xb000000000-0xb1ffffffff 64bit pref]
> pcieport 0000:5f:01.0: PCI bridge to [bus 60]
> pcieport 0000:5f:01.0:   bridge window [mem 0xb9000000-0xb9ffffff]
> pcieport 0000:5f:01.0:   bridge window [mem 0xb000000000-0xb1ffffffff 64bit pref]
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/pci/setup-bus.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 909e6a7c3cc3..15fc8e4e84c9 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -2226,6 +2226,26 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
>  }
>  EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
>  
> +static void pci_release_resource_type(struct pci_dev *pdev, unsigned long type)
> +{
> +	int i;
> +
> +	if (!device_trylock(&pdev->dev))
> +		return;
> +
> +	if (pdev->dev.driver)
> +		goto unlock;
> +
> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
> +		if (pci_resource_len(pdev, i) &&
> +		    !((pci_resource_flags(pdev, i) ^ type) & PCI_RES_TYPE_MASK))
> +			pci_release_resource(pdev, i);
> +	}
> +
> +unlock:
> +	device_unlock(&pdev->dev);
> +}
> +
>  int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
>  {
>  	struct pci_dev_resource *dev_res;
> @@ -2260,8 +2280,10 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
>  
>  			pci_info(bridge, "%s %pR: releasing\n", res_name, res);
>  
> -			if (res->parent)
> +			if (res->parent) {
>  				release_resource(res);
> +				pci_release_resource_type(bridge, type);
> +			}
>  			res->start = 0;
>  			res->end = 0;
>  			break;


