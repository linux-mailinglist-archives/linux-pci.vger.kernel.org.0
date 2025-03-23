Return-Path: <linux-pci+bounces-24461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB34A6CF5D
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 13:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E498D16E18B
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 12:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2282E3375;
	Sun, 23 Mar 2025 12:56:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFA32E336B
	for <linux-pci@vger.kernel.org>; Sun, 23 Mar 2025 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742734616; cv=none; b=UblEN4ZpN1VdNAy4bPpU/21QVuHejN0vrpIhPrEtnE0BDh3Nz24osxhT4S7ZEqnx793SbNbiJ3bqYKbpD00svtXRmZ7icpV4Wa5UhOTWV1HcnJ8MilIT35Cpiey92Me8/sKwAQ6js6CGtr7FDd8sKXpeatTBKQpcA9zc0Ztoi4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742734616; c=relaxed/simple;
	bh=46hKFX71keKHtbSXXG0BLhKs3lhIePe2LKtByWAP+Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgvzoK8AKpWWu79Oh9oHn0jkO4J5zZvWN+heikQyyRjZsf4jG7ZoV89BDPBf2/wwRnZLZ9W8raejfzWWRVdhSc+qGgQmLFD8kZxO98o4EecVUeCaSs26U8lqd306G3CcFWnMr29klwWVAaMD7ONEKi2Yc3V1YwowuFOAbEa7h4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2239c066347so77362885ad.2
        for <linux-pci@vger.kernel.org>; Sun, 23 Mar 2025 05:56:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742734615; x=1743339415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTjZra+B+J+uPu3AlVtnDpku2g9YtvywBzljnjYwikA=;
        b=p0FaY0lyqcleaLajHQnGMbR/YmBXvCMAHxfjUT+Icy+V395jvpJQ2j3LSLzNhEPWoT
         w5rkDs8v/wee2mVX/aKjSZXYS2eCCkNTxlv1cwmUD6OGmL+VQFUNJE/VMVJDXFA1J2Bl
         sEv01ipm34FMf5D4Axyd82oBSbyjlcUSKt3U/dqUShvI1GlaazWmwFSgAeJ3kosq11eu
         PGq9zeHHWPr944xYNCatDJnubxkGFSJKZwbrP/4vfIpuR3uf+4IUPuG4HOz9sw4bthav
         m+52LMVZrqNo8TkjaAml7cgVdcaydhBMe0cJmHjYAG+sCNB1ewDJcYVaFqGcpG75HJRj
         GR9w==
X-Forwarded-Encrypted: i=1; AJvYcCUjR6ik3h9IafIzbL1DNaZLHiHGCQdRRaubyKJx76c5t8OwMjEe1SriVFFL0/ypFVb/wSoYzJuk9jA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnG/kHV9drsb9laIZV5pgh3vy79V66kX5FZF2mf5mC/DBKRJO7
	qpkFoYg6bS99oFyxa5rBiNwix+3tWw8Nw9GuvNYs4+QBUeLyflrn
X-Gm-Gg: ASbGnctyO7stTGHyGBP6U0Zq0gRNp0MhzW94GGQOhS1KwhB1K6hLD/TaJ17+/Ar5yxO
	rnxzstZXqwhfQSTx8/2z5mP2hyWFcHBjbXhCAkiwalvpZ4SxhlQqDhT1WeSuSD2KPmfH0qz0tRd
	Ks2H3fXpsHDBRSpq2Uvp4JfyYKgCsaF1iKRVbCv5d6aPGzyPioZCocDNqydkP7t2BKbDm6exiOh
	PUJdlVFptnC3mUaqLEDfISjK4kGZ6Qec/tIrIO5m85szP1g99uzRHTuy3dQl4k1SkZL4yfFHxze
	mFb/KCokMioeyut9t/Ed9CASrL4K3BoVAk2ZGaSnI6uNNBH/qeTboYcYFG5jLegBe6x2bB9I3Fn
	0UsU=
X-Google-Smtp-Source: AGHT+IGcKbRw+9sI1I54i45BSoPwZWt5kKiPXWpYEAFxh8MY6Ko1Puod3hid+w6GMFPIB1yDsfgZNg==
X-Received: by 2002:a05:6a00:b4e:b0:736:34a2:8a20 with SMTP id d2e1a72fcca58-73905a2300cmr15308806b3a.21.1742734614668;
        Sun, 23 Mar 2025 05:56:54 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7390611d212sm5903762b3a.95.2025.03.23.05.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 05:56:54 -0700 (PDT)
Date: Sun, 23 Mar 2025 21:56:52 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Wouter Bijlsma <wouter@wouterbijlsma.nl>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI/bwctrl: Fix NULL pointer deref on bus number
 exhaustion
Message-ID: <20250323125652.GJ1902347@rocinante>
References: <3b6c8d973aedc48860640a9d75d20528336f1f3c.1742669372.git.lukas@wunner.de>
 <20250323112456.GA1902347@rocinante>
 <2e16d6af-7d7d-47a7-9c69-26f0765a83d6@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e16d6af-7d7d-47a7-9c69-26f0765a83d6@app.fastmail.com>

Hello,

> The patch is working, no kernel crashes and shutting down after hotplugging the Thunderbolt 4 dock does not hang anymore, thanks!

Thank you for testing!  Appreciated!

> I still see messages in the kernel log that 'devices behind bridge are unusable' because 'no bus can be assigned to them', 'Hotplug bridge without secondary bus, ignoring', etc. These all refer to the Thunderbolt 4 bridge. Adding "pci=hpbussize=0x33" to the kernel doesn't make a difference. Adding "pci=realloc,asssign-busses,hpbussize=0x33" actually does 'fix' the bus allocation failures (or at least I don't see any messages in the log anymore), but then amdgpu fails to initialize the IGP.

We can fix any outstanding issues or drop this patch.  I leave it to hot
plug experts like Ilpo, Bjorn and Lukas to make the call here.

> Anyway, all devices connected to the Thunderbolt 4 dock appear to work (USB, screens, ethernet) even despite these bus allocation failures, so I will just ignore them. 
> 
> Thanks again!

Would you be happy to provide your "Tested-by:" tag?

	Krzysztof

