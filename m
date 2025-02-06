Return-Path: <linux-pci+bounces-20827-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA73CA2B14C
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 19:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D415F188162A
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 18:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7441ACEC7;
	Thu,  6 Feb 2025 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Li4R5Y9X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30AA1ACEDD
	for <linux-pci@vger.kernel.org>; Thu,  6 Feb 2025 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738866840; cv=none; b=UxT6hrMeq4TOyeoUVfotEZshMjtyxnr2INiSpiS6ng+RMCipAUB+FkKopSVZUHREMZq2gnr7+AFMb8CxnltnhYhBPZXPQR+JL9jX82xgBuiJLZJx/M00gMADoCQCnyOfclgqofAxjpuYZzOJTxsnnrBVyfSpAA/+a/QaavGvZIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738866840; c=relaxed/simple;
	bh=IEHm0JVQD9vhqpPbUpsGp4ZoTO4v2nX596dwvqQ84pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjTwXUEA3aJe6A6Q+8/XzktHUd0Ez4ALQ7xPYstqFb8gtyHYkGsap/lK837VKcczQ8UB3tUOPVftM87YIVM5sFs9utZqdYuyR2BSNZRXmtIkErz9RxJlcen4Fojnr1pqhxBa7MlbG0bbTlIftYpyMKmW4iwR8ZudclotCxpnbfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Li4R5Y9X; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e440e64249so7051266d6.3
        for <linux-pci@vger.kernel.org>; Thu, 06 Feb 2025 10:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738866838; x=1739471638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lg9/xO+vwu3u5wtcCTmy67FWpXasZ+8fpiM6pmfr8Ek=;
        b=Li4R5Y9XkM17PZs3r3DkB19yehOhc4o7TkTqCJLRs+FFTMVzeeATNPX1npF2ikPknL
         J8czNHbQ0jzAtX6Dx2QMtN67O/rRl5T8aJgFCcQNoZ+yyfrAKpxucVz3Vgj6NbhFUXE3
         4qaaTiO0rVFgTb2EYpDM/wPfgAjLG7BHPqHQNZh6EFRv7GNW3QpH4TwYovNnpCQvzkdd
         jq4V1m41Cy8Xo4UeAJO3riEhv7TJSpMDtdi9R6gES/8MQpNHl56kRmh5E5OyXkaOh0dc
         tW7Fu+0yiMWi+HDpVw+mZfACH2BfbU2Jk0P9LqNV4p4sMxv0fQXMDQRldW/dCd+s6vpR
         O7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738866838; x=1739471638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lg9/xO+vwu3u5wtcCTmy67FWpXasZ+8fpiM6pmfr8Ek=;
        b=o+aq31wlCHUvoaDQFweiyAn0j1Y/6T7973JZOOkKsbtFQqjL0RQoS2DqGtaLNQujqR
         rVRWmU3EA98hUR7L4oVh8vJ+yWY6JHatq/ayHgNKB5ayHFRyl4w0v78rBcyvCsblqAHu
         RSno114qSKEvDuO8+SNnbmetZfLsaDHk4SPD/AiaDv5rQ/tClJoFK0u9jbimZtwCa9y8
         Cc72iAY2eQnU3585zxsw2JPhRGAI0pG44zBBuLmkqIr35uTbyEr+w9NSyBrl7E3VawxC
         QDlyFYt5gR6Jj7dFF5ZuHo9SQMLZU6vYffm8jSKHLqymqRG5y8I102uMhpNvL/QtBKAv
         bhKw==
X-Forwarded-Encrypted: i=1; AJvYcCUO2i7UGhlBluzbXHfhmcNEW50piAaLaW87VYn4BD476SbQrp2NNwoCYT2ucsG+akq/BnRwLEsWmdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwMBPHgjFW2D47qQVopvPgf3U5fxdAZ4d6d/mVv+9cW3EP+h8G
	eiUqotoaid92leVc7xWOzCuxnN+Ey+AN1G444UP3L3kRAc20/4I/g7HoAyglwSY=
X-Gm-Gg: ASbGncsTMlxB8nHA7tA+qLGaIV0BvbWhhHC+cYCF+ewHy4iw5OZDZILXanpEKWdg757
	SFChUqGHxC/33m/Su/x3KFf+N0udnPEG8r0j9S2sb8hYMJt7hge5UtFwZmjWFHvWgSqhGmXo+Sp
	4cW9iQTaCCnnVX7axCMdteatinNpd0lXv3W5B+4l6sqZntRgOPDhsJuBymXM26BsL8NwRRmZkRL
	n/UPSgOFtvqP0b5qB4zIHrfUZ0lbfjJDDa0v7EZpBA7l1ZTNkiYi7WyQk3F42Y7EbVUIwtiJTP7
	Cyt+c/sc9QRd6QXUXbVzPVeUQ8zZfRwHNUF97R7WEHRpwhpjvHhoVg2r3bO456PhzVMfMPN3Rg=
	=
X-Google-Smtp-Source: AGHT+IEw7WgSK/CFNZ9nsdIvcglDYx8Xa/A4d9Pce6M6QS8IzvMkCVSGYQct3kLg0drvssQpbMhwcA==
X-Received: by 2002:a05:6214:2467:b0:6e2:4911:cd8a with SMTP id 6a1803df08f44-6e44568175dmr800536d6.26.1738866837885;
        Thu, 06 Feb 2025 10:33:57 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e43babcc32sm8154696d6.113.2025.02.06.10.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 10:33:57 -0800 (PST)
Date: Thu, 6 Feb 2025 13:33:55 -0500
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
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com,
	alucerop@amd.com
Subject: Re: [PATCH v5 05/16] PCI/AER: Add CXL PCIe Port correctable error
 support in AER service driver
Message-ID: <Z6UAk_L22eqiWCix@gourry-fedora-PF4VCD3F>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-6-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-6-terry.bowman@amd.com>

On Tue, Jan 07, 2025 at 08:38:41AM -0600, Terry Bowman wrote:
> The AER service driver supports handling Downstream Port Protocol Errors in
> Restricted CXL host (RCH) mode also known as CXL1.1. It needs the same
> functionality for CXL PCIe Ports operating in Virtual Hierarchy (VH)
> mode.[1]
> 
> CXL and PCIe Protocol Error handling have different requirements that
> necessitate a separate handling path. The AER service driver may try to
> recover PCIe uncorrectable non-fatal errors (UCE). The same recovery is not
> suitable for CXL PCIe Port devices because of potential for system memory
> corruption. Instead, CXL Protocol Error handling must use a kernel panic
> in the case of a fatal or non-fatal UCE. The AER driver's PCIe Protocol
> Error handling does not panic the kernel in response to a UCE.
>

Naive question: is a panic actually required if the memory is a userland
resource?

The code in arch/x86/kernel/cpu/mce/core.c suggests we may not panic
if an uncorrectable error occurs in this fashion, but simply a SIGBUS.

Unless this is down the wrong pipe - in which case disregard.

I'm still digging through background on this patch set so I may be
barking up the wrong tree.

~Gregory

