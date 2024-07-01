Return-Path: <linux-pci+bounces-9541-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FD891E9CD
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 22:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66034B21695
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 20:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F6A83A19;
	Mon,  1 Jul 2024 20:48:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D161366;
	Mon,  1 Jul 2024 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719866897; cv=none; b=Z+8apEA41mPg0aflovSRbgJ6dxGGdheuw89hKFT4AD/WTy8xPktvviavgzBmP8H8PLnbdR0pItGsN28/XN2UyHN+J03XDs8aJbVwObA6b/DTL1k2b7QVjNf8ANxih9dLOKppgbZDWnZ2E2WaP+Oee7jPNzB7jKBAoh7vdhE5rrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719866897; c=relaxed/simple;
	bh=VYRfq/MfPWpVdVqHlzAD+N4k+na090ubX/RfH4sq8MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGbmHXIOKMawInty+7+0CvQ5Betr4aEt7smmzsRFx70ltjCmIbd88Z5YPj6R8L0d46VLIEF25IKW4CapHEdQ91hQNlV+NHq7xEeQzW6ilqg40A+dS6Y21n+Ch0RA4k8acKVHCh8gdt8KDRLx0Wsn7PbcpfHQsXITSsQ+jbWoFQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70671ecd334so2668896b3a.0;
        Mon, 01 Jul 2024 13:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719866896; x=1720471696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+vwAhe52gi/wKblVVP4vT7KtjZ4YJC+9NjnxhSRlso=;
        b=UMBqdKDh85g2y17RgK5Am31hyz65kMBop/oNsFVIpKSnldjoTO8S6BSY30TwEde70g
         D4yWsQ7EJGXz4eQkopBWWqv0FrrYKgm2VW3xdaFn400PMS6hoAvHKrKCU+E8pqXUDl8g
         BLocGWSxfBP5WBlOkd0XagXaBFvqsCJmlUwzrwCPHkmucPcx/HDhgfLmyvixV0Gwj7Ls
         Mki5L48+bQoMD59hHuo4uEV/9sS+zNyS+w4YhNJ+n42zVJepy5IVYnfscZt/CnmOD+kw
         zBmxhyjfISq13nDYWmsN5wiaVoOxEMPQcrdx2t6Gn07EublKqPmz3MeMDRJADs6Vgp8L
         Ihpw==
X-Forwarded-Encrypted: i=1; AJvYcCXOTdt9Dw1EEEaJNdEkPllRDzARBuYem1EGrvXZ/GESLrTDxm/yJOtgQWQGG7gJkquRWCDZmVvEF63m2PuFV7tKC5xTc8PFEpzJ8nPdDHNq7w1Wj0q+Mf6v/eTGvSUhfWx7kGbsCfeCy4l6PJY=
X-Gm-Message-State: AOJu0Ywb/DNp/cwvEq7xi2nKW3AM3kaG626zczG0Lje2dsHXgW91vC0y
	YRRqumFsHbjGYjdA9wbscA5uKbRXUDJ1eVWE4AFhOaC8hxdqOsYm
X-Google-Smtp-Source: AGHT+IEMoV0z6QhZSQ4QNBFHFMHODQfwxB9Z0Duq619IJLwA1b4El13BrVTwj72uTz3W09XZ/1qErQ==
X-Received: by 2002:a05:6a00:b8b:b0:6f8:e1c0:472f with SMTP id d2e1a72fcca58-70aaad3ae0dmr8801123b3a.8.1719866895509;
        Mon, 01 Jul 2024 13:48:15 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecfb09sm6974228b3a.136.2024.07.01.13.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 13:48:15 -0700 (PDT)
Date: Tue, 2 Jul 2024 05:48:13 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v9 0/5] PCI: rcar-gen4: Add R-Car V4H support
Message-ID: <20240701204813.GC412915@rocinante>
References: <20240629200650.GD2249818@rocinante>
 <20240629204620.GA1482128@bhelgaas>
 <TYCPR01MB1104020A6F6F4FB896FEE717ED8D32@TYCPR01MB11040.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB1104020A6F6F4FB896FEE717ED8D32@TYCPR01MB11040.jpnprd01.prod.outlook.com>

Hello,

[...]
> > > [...]
> > > > About the firmware binary, please refer to the following patch
> > > > descirption:
> > > >   PCI: rcar-gen4: Add support for r8a779g0
> > >
> > > This quite a sad state of affairs, and usually would I oppose including
> > > drivers that rely on closed proprietary firmware blobs to operate.  That
> > > said, Renesas is not really setting any precedent here, so we will live
> > > with this.
> > 
> > What are the existing similar situations?  Just for curiosity, I'd
> > like to know what precedent we are relying on here.
> 
> Wolfram mentioned it on previous email thread [1].
> 
> [1]
> https://lore.kernel.org/linux-pci/53sfkav45djcaapqkzsps6ofsinf5lnxbhrjvgsevt3w6qcms6@e2vptwrj645q/

Another example could be the Marvell's (formerly Aquantia) "Atlantic"
network cards family, which requires a custom firmware blob that wasn't
readily or freely distributed.  The firmware files were never added to
the linux-firmware repository.

... unless things have changes since I looked some time ago.

	Krzysztof

