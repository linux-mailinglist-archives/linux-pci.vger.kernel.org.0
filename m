Return-Path: <linux-pci+bounces-7611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 534678C8576
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 13:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1ED91F22DF9
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 11:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7063B78B;
	Fri, 17 May 2024 11:19:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275343F8D0
	for <linux-pci@vger.kernel.org>; Fri, 17 May 2024 11:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715944797; cv=none; b=g1IEpbZCQbUl9tOOIt437QzyaUeZc3MxKoR4JpJqBowK/gZL69cLw/a+lpF0BA4oG1w0kTFayY/19eFhPtcpk7X7vujdMzuSwO/s/F6kMYyucWcF2TMec4NrrpdE7Y57K8KCa8sSNbGqPPVCugd+4RELsdqKN4GsISloS4SAaps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715944797; c=relaxed/simple;
	bh=DLGoajIYlvlivwZhgXcFKBBha8wPK6MrqPTgfVuRv+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aHu7GEUGsZSo2MfhWBOazQz4wBsC54nEGPVuzRJShNEh6qzbuL1FPa6hPOEdHNzD53Mk9k4Jo40n6lCuJ4MmuGtrEMaRwIxBWEKR978o/UQSH8JBMccoW0dCwn3uR2VuXHfI71kQx9rzrSS+LCgPPIR+/VjYTrCI2nzRW+xpZUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1eeabda8590so4712875ad.0
        for <linux-pci@vger.kernel.org>; Fri, 17 May 2024 04:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715944795; x=1716549595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysN0ROd4aJxVqOS5IX1BKY4ICPkmZb0ZSOUJ47QUlUQ=;
        b=EdHCgfC8aj8Ot9k5cY4hKJUicltB7F60KGg8cYOte9XPf5P1Phd1XPRYSMRnSs9Mh1
         2XXQLkIEMqMlpWCzmdbF8ZLeEdtRQTPO1txpXFpAfXBaKltj/QniPvgeLGkdp7w++Rkk
         3VzabUpzhce588qzwA2FhwKjurM4ZiLGI/i5zwRiFDlEibEr6E3um7raiyi3Pj8tKs2I
         /pdX9nwyBkAR4DoLgQIHH8/7FUcWwBuxN4IyRK5UK+nxEAONxooHmNK3exSIgaaHUjhF
         wgl7DoMjz+2qbVTpkkz+xtUrhQEcXedyj2c+zsTEme0bRwY5+enwMFw246jGjEYQpCcj
         YEIg==
X-Forwarded-Encrypted: i=1; AJvYcCVuIKp6hzSqrkGJBmbVNFzcfIdThyiinNrgW8juXnoKlWBpYwP5ReCagtU6XIdDvyyqoeyvg9D3iDbqVg0d96nh8Y4UP78CoprO
X-Gm-Message-State: AOJu0YzfObnd7vuJQ3fDgCudQMCsJYHlLMoXcIaL8MRUGzX2mBgbXdVU
	G6zikKH1yjEM1km7FtI4XnpdR2lQ4C0BZ7Kou1KFHt7FDRrUAHqS
X-Google-Smtp-Source: AGHT+IGur15vntAU/MQOSYbsND3WB1TbI/5fELdfbxBqKI/c+l0TBJn+5Y186ofKzK0svZUAOp7KYA==
X-Received: by 2002:a05:6a20:4313:b0:1af:cbe1:8a50 with SMTP id adf61e73a8af0-1afde0b5bfcmr22050469637.10.1715944795534;
        Fri, 17 May 2024 04:19:55 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af52b4sm14939490b3a.174.2024.05.17.04.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 04:19:55 -0700 (PDT)
Date: Fri, 17 May 2024 20:19:53 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/2] rockchip rk3399 port initialization fixes
Message-ID: <20240517111953.GS202520@rocinante>
References: <20240413004120.1099089-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240413004120.1099089-1-dlemoal@kernel.org>

> A couple of patches to have the rockchip rk3399 host controller port
> initialization follow the PCI specifications around PERST# signal timing
> handling.

Applied to controller/rockchip, thank you!

[01/02] PCI: rockchip-host: Fix rockchip_pcie_host_init_port() PERST# handling
        https://git.kernel.org/pci/pci/c/3392b74f3065
[02/02] PCI: rockchip-host: Wait 100ms after reset before starting configuration
        https://git.kernel.org/pci/pci/c/46a610678fef

	Krzysztof

