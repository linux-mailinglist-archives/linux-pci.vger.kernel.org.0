Return-Path: <linux-pci+bounces-35060-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AA3B3ABDE
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 22:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B0E07AA59F
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 20:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809BB29BD82;
	Thu, 28 Aug 2025 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMgXG6c5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5603629B8CE;
	Thu, 28 Aug 2025 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413867; cv=none; b=rJsDvggg1T6FdN7F6Yj8NRFZc+4hMIalwy9pT/PR/fMt7o1sB7BofU/8mSBiDNkaAK9T6/aAcrNCv9YtEAcFIgoFsmoUk8YbYl+6N4Ott9GRU0/3eWDJVYNWZiqHHR8+241WDBK/oCXbk3Ns3a/FB8f2NBdyOue+VLTDq/BzZ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413867; c=relaxed/simple;
	bh=A9xfoMdjSlzEQbmFLxGNICyxTXVOKwf8U9SEBOi7zxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=anDQRyj/BpTodTiPgC6oxFf2bdH37hsJLvxy6xXDrtMcWAsejZJmR8sd/Z+rFBe4ryRW8BdjfmfdyNlIusEdk9lSZCJdPIW7vqOAQy4TkZmrSJBtHYg8LBlH0ZnOvRygMOxkO0TAM2sT4Qmg/ctV9kUCXN7ON6Yp0YCFjviH8gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMgXG6c5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB829C4CEF8;
	Thu, 28 Aug 2025 20:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756413866;
	bh=A9xfoMdjSlzEQbmFLxGNICyxTXVOKwf8U9SEBOi7zxY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sMgXG6c5r0F2j6uHbAxUEXg/Iwjpuhdsp6LNd5Ay6Zv9W0brGD5gfn6FPjIp+3DhJ
	 YR5VLpJ6lfIwZUAIId3v31Rct4ZZHkFUCoHUyL2jCaaUsxcIpgKz6/AM3f0QSpBiP3
	 Vn0e1Umw7u8TDr426GhX5Y3lNIK9regzoDgEkXxiH0EFtwi1KNULIfWP0oUhIMfzG4
	 +qVbNoECgOkA8phdPnSiJV81viuvC1m2mqvxnkq21X4Md+mcRzHEswYHD46s0gymiA
	 SeHEfKOzjytyy6HzyVIKCg0+2A0yO5pAAHyC/K5GRMdvsb8aFRSF2Ak5LY6qUhkFy/
	 zR+WiGGXikRPg==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61c51f57224so2031443a12.2;
        Thu, 28 Aug 2025 13:44:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV2FegJCDY1xpLX52R25TzSbGgbraV72Fo5KcNAia/kfn2LoXv08vihyjfwDUX9z0TKuVF82nVSdSZL@vger.kernel.org, AJvYcCXc0CzhMce/VfMHWqFJ4cdaj3K9CrtqPvUvEiKq/zV+fIxG/GuvBYMw7AmAfU0gKiNFpp/QpaX7vd5tAVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR7tGo6KjwEDXHM0D5C+vgCduf2sSS2V4LKVNOHBSmzD/3aMHD
	19jx0wMMiHGDTTBq+xC2NV5mQgstDtjLrIwQE/WpCQ3vt/FlMgpH48hXWqQ7Tw++3A10ElEShu+
	eDh6QorjVA6hKOWLgoP33YJr/qqH6jA==
X-Google-Smtp-Source: AGHT+IHmaHsGzXsqZXLP072B8v9yXmczlE7ISXk6+PoY7QHyc5iqZ1e6HF7CJWcJn32gURZBOWNTew9u7ZvU1rpm47w=
X-Received: by 2002:a05:6402:50ce:b0:61c:45bb:18f9 with SMTP id
 4fb4d7f45d1cf-61c45bb2065mr14665701a12.38.1756413865474; Thu, 28 Aug 2025
 13:44:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828135951.758100-1-18255117159@163.com>
In-Reply-To: <20250828135951.758100-1-18255117159@163.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 28 Aug 2025 15:44:14 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ0cXB4bz+DAUq25V5suS0D-CHnujh0UyxA66UjajJO-g@mail.gmail.com>
X-Gm-Features: Ac12FXyKWvd7egVBT8QtrvjiQm0FJq9Mat_qcB8tOL6kSDNTTls_deGOK1a5IJ8
Message-ID: <CAL_JsqJ0cXB4bz+DAUq25V5suS0D-CHnujh0UyxA66UjajJO-g@mail.gmail.com>
Subject: Re: [PATCH v5 00/13] PCI: dwc: Refactor register access with
 dw_pcie_*_dword helper
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, mani@kernel.org, 
	kwilczynski@kernel.org, jingoohan1@gmail.com, cassel@kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hans Zhang <hans.zhang@cixtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 9:00=E2=80=AFAM Hans Zhang <18255117159@163.com> wr=
ote:
>
> From: Hans Zhang <hans.zhang@cixtech.com>
>
> Register bit manipulation in DesignWare PCIe controllers currently
> uses repetitive read-modify-write sequences across multiple drivers.
> This pattern leads to code duplication and increases maintenance
> complexity as each driver implements similar logic with minor variations.
>
> This series introduces dw_pcie_*_dword() to centralize atomic
> register modification. The helper performs read-clear-set-write operation=
s
> in a single function, replacing open-coded implementations. Subsequent
> patches refactor individual drivers to use this helper, eliminating
> redundant code and ensuring consistent bit handling.
>
> The change reduces overall code size by ~350 lines while improving
> maintainability. Each controller driver is updated in a separate
> patch to preserve bisectability and simplify review.

If RMW functions are an improvement, then they should go in io.h. I
don't think they are because they obfuscate the exact register
modifications and the possible need for locking. With common API,
anyone that understands kernel APIs will know what's going on. With a
driver specific API, then you have to go lookup what the API does
exactly. So I don't think this is an improvement.

Rob

