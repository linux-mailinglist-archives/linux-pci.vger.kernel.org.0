Return-Path: <linux-pci+bounces-27304-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7744AAAD176
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 01:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12B04C295F
	for <lists+linux-pci@lfdr.de>; Tue,  6 May 2025 23:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FF01B0F0A;
	Tue,  6 May 2025 23:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ltMMkir9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6834D19CC0A
	for <linux-pci@vger.kernel.org>; Tue,  6 May 2025 23:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746572796; cv=none; b=bqZbJOQv4a2u50C1GheNL9Z16tUZYEYY86wjBLfYTekNfTQ+6xX76G/vzOr1T/TaDQcgMpL1Kc56m/ype0Y0aPwn0RniaQcGnj/eVgniIniRVr826Bqdp1WBo5SBr8MnHjiPpODHSN+JIWZ3zon6N772ppHj/VkoreMG9yuZqdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746572796; c=relaxed/simple;
	bh=AkWTf635RjG0EvzFpzLnPFZugQ89hkoZEH4JSEwN0ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPYEqHsIsLyBp9cURQN/diK3juHBqG2f5j6q8Ssqcjm8sX8TLuzTW759akCmB0MJz9FQiJCpfCulf6yw2Uubk4JiGdh+B44iblP/orC5XKCDSNHR6XjNUQBrFX44tQrlY+C4gg26/yuFCZq7vP9KzhOTI1sCcVTLAU7p0pjHpyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ltMMkir9; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e8fb83e137so60074486d6.0
        for <linux-pci@vger.kernel.org>; Tue, 06 May 2025 16:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1746572792; x=1747177592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jMzOedZBUFQh6ZOzmCW4ghlDT1S6oF17/0z00FndM84=;
        b=ltMMkir91qDPV3NyGesMnX9DIlK4Nynun0G4iANXsHtee4tkC/GqUKj7ii1kFcqBf4
         IlpHUUvbnljkBM6RtO5JSIJXix8BaAS0gzHqpUsznN/YIZiLV4Jl5+hsnR3c4AUzflN+
         U/cuF9omvO1GJAWmN6jQ9/0bd8MbiMobNkb8r+zKG2HHn77vtzq7zjMgIDKkxERE5NK8
         fmkCi83BEolUSpV89YO4DLTUGt5+VxGxhUaUP2XCrQq+XVyfqBFN6+9ZlG3hw2c0WjEG
         62FBVZ2hxPXlw6w9SU0dEk5sq3CeoSw9s3m/QGprf856/RiOm6q6B4ezIztJvbivwvWt
         0/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746572792; x=1747177592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMzOedZBUFQh6ZOzmCW4ghlDT1S6oF17/0z00FndM84=;
        b=k83QFgmmr5DpuWmiSnXNynA0erTALestIGqcB+caaW/Rxf8zUSxjp93Ngt6yu8rhIu
         xB5sE4Fu/fc5shNUnPxW8m6yOp5gzPsI+pTnR/oYFDRrEvnB7LeRRhsZZgdFoMpKd3aC
         x25rNfKU5IgTF+VA3ZMF0HgpWcAt7X6wgogMFHtSnNarX59CpAEK3+9iL4e8tUToNFD5
         LnGM9o1l6ZMjGo3qYbXM+iJzQd5WnQ0Y0DAuLMFvuj9pjRIRruA6hzIHR6tAJECCzQad
         HBlkQOxjvtAowgwd6y5fh6bSR31Tmv9HNhwJBgy1ZsZJHm6vcN1KJHoI1NhK18Cf+kCy
         FQIg==
X-Forwarded-Encrypted: i=1; AJvYcCW/TMdU2u5NG48SHmW4h1FCOvAUpPRYYPSBKZo/p7Qfw3KYxsvH1VzabqqkSJITR20H1V9p9ZMVVgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7zLCRay/C7uBDT5sCm1NrqR8NAmyTepY5sb1QpAoy8hyIpQVL
	XfVj1toPLUna94oN6f5mTq/TpGJ+T5eApMjEFriKjr8iN1HkDmpOJKrUw8mgxdQ=
X-Gm-Gg: ASbGncsSzTMpjhtaxtJ0sWwFncJ2JN9UyMXUQo9gGdNMHpuHkUR0l6yNQ+V1GQlljsE
	9xPW2VapV0GF2mF7s3k1CxwE/ec5o861V6Rd/b8CW2mSlb/cpi1VCKgpRfQsB+3Mk0a45RC/HfQ
	N8QF4tGfArrnUa/IZ04oM6cdNwgmsrG3VsuL/WUGR+zR5lsDc0EjqSkPMElD2Z9Aa2Kb8nRqhx7
	TCeE62AqM7btBJAFv2Dn6YJkWZVcZDy+ujw7lNbpyFNiyeLv9t69NdNl/Em6jqJLmOExqWPZSpA
	rVzz7qRAN8AghC5BY7F4Hv4jy9NlXcttnXHp3eGLEfSiAfc621hldAqZqtIuNomM28uekbrmcdo
	4KlrQWpVyAgOMFQQZwvOd
X-Google-Smtp-Source: AGHT+IFHH0FvrhCCJDSr9P751dSZJYI7LDjUr7c/DSSKJlfVzJvDae2X802XdK+1BLRbg8tORhZb0Q==
X-Received: by 2002:a05:6214:dcd:b0:6f4:c824:9d3d with SMTP id 6a1803df08f44-6f542aad789mr18656576d6.37.1746572792237;
        Tue, 06 May 2025 16:06:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f5427d40b9sm3559536d6.118.2025.05.06.16.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 16:06:31 -0700 (PDT)
Date: Tue, 6 May 2025 19:06:29 -0400
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
Subject: Re: [PATCH v8 00/16] Enable CXL PCIe port protocol error handling
 and logging
Message-ID: <aBqV9UCF6dQFtcyP@gourry-fedora-PF4VCD3F>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327014717.2988633-1-terry.bowman@amd.com>

On Wed, Mar 26, 2025 at 08:47:01PM -0500, Terry Bowman wrote:
> This patchset updates CXL Protocol Error handling for CXL Ports and CXL
> Endpoints (EP). The reach of this patchset grew from CXL Ports to include
> EPs as well because updating the handling for all devices is preferable
> over supporting multiple handling paths.
> 
> This patchset is a continuation of v7 and can be found here:
> https://lore.kernel.org/linux-cxl/20250211192444.2292833-1-terry.bowman@amd.com/
> 

I've been testing this for stability on a fair number of boxes for some
time - backported to v6.13. Haven't seen any major issues related to
this set in that time. Outside my normal wheelhouse, but for the sake
of runtime stability:

Tested-by: Gregory Price <gourry@gourry.net>

Trying to get more explicit testing feedback from RAS folks.

(note: there appears to be some conflicting changes in v6.15-rc4+ that
a bit outside my current timeline to forward port and test.)

~Gregory

