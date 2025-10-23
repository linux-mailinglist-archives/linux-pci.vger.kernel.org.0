Return-Path: <linux-pci+bounces-39173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBD2C02776
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 18:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96B43A3274
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 16:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B4830E0D0;
	Thu, 23 Oct 2025 16:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QcTgrd3M"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1B4D515
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761237286; cv=none; b=NCLh0Ptn66I+ziq71k+il6P4J9mHX1DwujtIeaf+EnnfryAongL7tkjNjrYDM0rCPtX0JbgNDbjMnbmwLHh+3YBIaMWCQwpJ6qmMv/3M9GSLo/1cbLo1ZfrYIoK2R3nGR3WTdwlPsfM/1jvy5RgDW1p8N6jHTjN6A6VE1GLOlk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761237286; c=relaxed/simple;
	bh=NdJU3UtFyyI6EAB0mdJauQZVuKzjWi525UkH7p+1tDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E36hn7YXXkhcMOMrQxgHCGs8lUqINiVImoPqsaOV9diVduXXwui0RjwWytOUqTiLDwuXFpX4ys8tivepVrLuDwECPbufOvZLl2mQBe1DEjVFJsjvBOg2kdsBfy64vTP2nmC7wCI+1MBizn5pcZG40Ho+SSE7FziX+fPH5UqLJ3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QcTgrd3M; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-33d7589774fso1179701a91.0
        for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 09:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761237284; x=1761842084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nX9LAccgZaMv+QMKej4XlkjO3db5yZqhpWW8M0KAbQ0=;
        b=QcTgrd3MF2as7trvAq9GUBgnCl6e8kPYjIu+PCkUvV5pYGVE6Q8XuoN1I6i+FyISS5
         A5TLn35y4eaKjFfRAPg1d6UqJUnkowBi8dInSm41qw8Hac0crHVd0XpXPXLHYSGuMX4y
         7qWq7DrnU9YZD+Jo69lLln1HaltB04YcxlzXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761237284; x=1761842084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nX9LAccgZaMv+QMKej4XlkjO3db5yZqhpWW8M0KAbQ0=;
        b=Sa6OE47xx3z/b9NRrK7m4N56HvmUT2OukdBHCWK3ZpHPFMnV9gB+2P7V7wSXJFNxKI
         KdQB6R+QhpZ0LCuCYonWZUrKkbQHwoFGwImsPeV5PgUalSkVkWh1jWlLZdxsEBRYH5Uh
         pmmveEie4wTkDyFwI3WXNirOz1iA/kTyshc4QjVhmk/9bkXT+by5Vt6x1k8hxrPVbFnq
         6EQS0RR3rPU8v3dXILRKHHrLseS8wfE/3yExO9PZz/HX8MdsGN+4DxGPS1q0xrrI9QXi
         SHXfcnIe7P8618Hd/Mra04irrg1fYJY1B7fTV6hjUNcjDkMs9fRsMNtqMO0aTdJ0oCG/
         0QgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzJGjpZDQf4wTkT0Ejqh6V2eCY3t2yAxorIamLIoss5TEhDh4hlle16B0r9bBiWhW6KfDRDXflCsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZbeHhEaHb29B+roM4GvVjoqk/2MDgszyLTDddTgnaiJoGrLrt
	NYUrUz3s3kQOauh5kTz7+eOb/IBQGbMj1xsJZhRXvcQz/dnkdkiGMkXbZNu2JBeW71NWBz3vbRN
	AZcM=
X-Gm-Gg: ASbGncsvirzj7uNh9sc/ZyVTT0TeSRAhfMxHp4ZAOJGl4R7mrQUlZP/xw1UhfoAnBTV
	cXlfZEyj8Ag/gOUL+3XRZlBttHcaGkxC/0B8dJ/ZMuf4rQIVHfEsMVzNyRZhAzhldkAXxoKDaW/
	dGOUngN1pMVXYBgS/9v7Uc+PzCBFyh51ObYJWcbTZxxkP1qnc8iz+n20ldYXUvsxwIBXb35JxDx
	l6Fcv4WUuNbkS+uyRpCR+VUKc5FyDFXz49HyBtMP1XdDEIt6BolBB76K/bZsOd0rNVRDLGCbz1H
	uG4MfGEtXLAF9Ye9ETFLEzIVZQJ+r80QR9PBt9gbkgcJUmMiZ9TETBAtf8pYg7MWdC5ff//pU9f
	+aYP7ze4PmXysic2ZdIzoDIX+pfks6/03h4LZ4SqHU3a/NxGdt3I9QpJDwGvLUbP8TS1i/xSbz9
	qLxOxakq0N92vJz6N4kT7n7t61hraOLWGftHteyg==
X-Google-Smtp-Source: AGHT+IEynXNDvnfI8YSlbXXclhPHM5qTj+zDVsUpWXh4APjJovTYiDiqoNYTvE67pyZbtDRPxrgDHA==
X-Received: by 2002:a17:90b:4c92:b0:336:b563:993b with SMTP id 98e67ed59e1d1-33bcf8f9153mr34119278a91.28.1761237284591;
        Thu, 23 Oct 2025 09:34:44 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:839c:d3ee:bea4:1b90])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-33dfb683d79sm3983674a91.2.2025.10.23.09.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 09:34:43 -0700 (PDT)
Date: Thu, 23 Oct 2025 09:34:42 -0700
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Ensure power-up succeeded before restoring MMIO
 state
Message-ID: <aPpZIovpDU2KU_gg@google.com>
References: <20250821075812.1.I2dbf483156c328bc4a89085816b453e436c06eb5@changeid>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821075812.1.I2dbf483156c328bc4a89085816b453e436c06eb5@changeid>

On Thu, Aug 21, 2025 at 07:58:12AM -0700, Brian Norris wrote:
> From: Brian Norris <briannorris@google.com>
> 
> As the comments in pci_pm_thaw_noirq() suggest, pci_restore_state() may
> need to restore MSI-X state in MMIO space. This is only possible if we
> reach D0; if we failed to power up, this might produce a fatal error
> when touching memory space.
> 
> Check for errors (as the "verify" in "pci_pm_power_up_and_verify_state"
> implies), and skip restoring if it fails.
> 
> This mitigates errors seen during resume_noirq, for example, when the
> platform did not resume the link properly.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Brian Norris <briannorris@google.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Friendly ping on this one.

This bug causes quite a bit of problem for some Pixel devices, although
that's admittedly because of our own failure to resume properly in some
cases. (And we can recover later, if we don't crash here.)

I believe the patch is still a good addition for everyone, in case other
systems fall into similar error conditions.

Brian

