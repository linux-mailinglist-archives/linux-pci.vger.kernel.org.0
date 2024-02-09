Return-Path: <linux-pci+bounces-3280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A261A84F26F
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 10:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A621F23BE0
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 09:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A14F66B2C;
	Fri,  9 Feb 2024 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="TscdN2De"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B295669941;
	Fri,  9 Feb 2024 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707471709; cv=none; b=ADx3n2NUI3uH5bdR5s/ijfjgffxSN9ig+WZuA+YC2XDyRzLyImZMEv6XwK/iluOHf5nvxZR20JcReSxiDQ8JLEe1ujmOEJeOG6j+lVM+GlB7xEguWzy84ZwUp3+4cKYBJs1ydoOh/OtV1WuJIHKovxByQoUejSV6GFPBSHI4SO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707471709; c=relaxed/simple;
	bh=1wdytBEQFps+fZJwpKDLujv0Zw9wvXD+jt7ixMMCIEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQLyu7hazMMG3/x3cjpBuws/jiHZqGTrvy5Ica0zq8rNllkzD02vwlb3Ut6iFwnSX5swF9M7BzOn4b1eB4Somh1xXBsiIN/z+v6E5TopnAGKVLwQ/9Peo2/aX0GOP288luNPsTu6lLLo5AVTuDJy7c5XIirpsCURHiwuUQ75l8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=TscdN2De; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d731314e67so5147845ad.1;
        Fri, 09 Feb 2024 01:41:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707471707; x=1708076507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5O4VeKCRT+/N6U2elWnRtoe+VFLcjIGIkBsMEvueNTc=;
        b=uZrBbP0rOlbyO73I3W/GqDXxC8gz6kOSzY6t0o4pMrJA9k81CIrqkj3Uz8PZmYY5J/
         1irPl+d8D1ZsOHGGU85Jh0oj/3+zsfu6Hu3TprRtwjnlTyozEuKW54oYvjZIJoUiWvmo
         VzhaXJn+JjVGgDuLvcmooeqsByoBPtsDoSTwtsQikO8UyTnVcpkBBiZsz1n3mwEbbz6Q
         A2cMT+W9MAphD+K6ENiPFewPVxZ5yQxlhgAjou7KMtfC8dBgqxam2XCkOQT2FCwAH609
         eMjUxIIh9qZxVZxKDsERXu2BEHnw+tsOjdyO7q7R00asbJQ5EkzWNB4QyQ8RnZdO0jUD
         0wHQ==
X-Gm-Message-State: AOJu0YxYcL2PCy0MD/oeeyYdQy7aEkRxajtcx3tHrjfYC2HzEKWpPj+f
	rXvPcSxVDlP1vdb3OWJuf40ushSOc/VPtXk9POveF44rhCpyyHxr
X-Google-Smtp-Source: AGHT+IGQtJObNAQd4OUi5M7NOjHQi2Tow1ZaojSRn1uxfsm3k9shr2/fdXMydk2eC/WyurGEe+oMbg==
X-Received: by 2002:a17:902:e881:b0:1d9:b59a:5bad with SMTP id w1-20020a170902e88100b001d9b59a5badmr1165349plg.53.1707471706796;
        Fri, 09 Feb 2024 01:41:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUoR4HFu7b0HvVz3SXh0QetFbQ5/PpozD9qHsy0myoukpiRGeC891xfcsx9jvct4Yf6s6f1XIsvCj7WKdnL8vKS6bBzZdfdsPwh+YsmbBm2Tva98oTLICltzvW/chRncxsT2XidWZCbXTrO+dvjVAm4aTab5CXTcfSeT3KAiBsERCKmwQ==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id kl3-20020a170903074300b001d961ebf31bsm1139991plb.82.2024.02.09.01.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 01:41:46 -0800 (PST)
Date: Fri, 9 Feb 2024 06:42:18 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707471703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5O4VeKCRT+/N6U2elWnRtoe+VFLcjIGIkBsMEvueNTc=;
	b=TscdN2DeleM+jV+ULr70xIL9YzikXGEJsU7CCe5x4ZxXcLh38T5oMBnYSApKG3PSOX6Gdx
	myZEN7kWjO8aWzVkTPYQfq+yvayZq79X5NxU+ZXgMpez3DwGCDYhZOmOzLYF4R0jzFZ24R
	Zd7faQKn96+66jW83kUHtjtOtrAHrqHuzbxmUKIUdvZ4OegOapSvhDSMcfjdR9pKxH8gGL
	+MPkxb78TCoEFUAhIGbN5A0yIS/iL7x5XbtoKOksIqCMUYFGDNYBgfCDChlQ+gSIgFY+QY
	GGrR+cZXK3vINz5v2UaxLS6UQid/bFOMysnsC5zE/Ggejh0AfD0wA7EccqPQNg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PCI: make pcie_port_bus_type const
Message-ID: <dwyznwixacnq2p6pm7lmyvsadapv6bxshx5pgxh7trc4v2ce63@urc4b2gqkh6a>
References: <20240208-bus_cleanup-pci2-v1-1-5e578210b6f2@marliere.net>
 <20240208210058.GA971698@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208210058.GA971698@bhelgaas>

Hi Bjorn,

On  8 Feb 15:00, Bjorn Helgaas wrote:
> On Thu, Feb 08, 2024 at 04:41:46PM -0300, Ricardo B. Marliere wrote:
> > Now that the driver core can properly handle constant struct bus_type,
> > move the pcie_port_bus_type variable to be a constant structure as well,
> > placing it into read-only memory which can not be modified at runtime.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> 
> Applied to pci/misc for v6.9, thanks!
> 
> Subject line adjusted to:
> 
>   PCI: Make pcie_port_bus_type const
> 
> to match history.

Noted, thanks!
-	Ricardo


