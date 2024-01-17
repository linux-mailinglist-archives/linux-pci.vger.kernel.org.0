Return-Path: <linux-pci+bounces-2279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AE88304FE
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 13:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FDB91F2573E
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 12:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7211DFDE;
	Wed, 17 Jan 2024 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="gSHD0ln1"
X-Original-To: linux-pci@vger.kernel.org
Received: from nikam.ms.mff.cuni.cz (nikam.ms.mff.cuni.cz [195.113.20.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A589A1DFDA
	for <linux-pci@vger.kernel.org>; Wed, 17 Jan 2024 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705493463; cv=none; b=p9iNGjSTHCHlTxX95m47hODmJ53pVfRhYHRSx78kK9IHrnCDwdqAlqJjnx0uMH0RsVjDGMM1tVHu8VgLDo8nbcvJUGDS7J5XhrD7hNtH6v/TSxWSRFYKVsmZSvZyY5Dn5xHVNR33+8lje085q0rK/pY2vFqZ5f4I4tPQhFTAsyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705493463; c=relaxed/simple;
	bh=9rufJ9X219Y0x6OQQaF76uULOjtp3fiYpyUvU9VHiOE=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=GI+FJkHNbx4O0/lmpPbijprzCob9lhxMLwkDJRE2hj0BMEaDt42f2KdQeO4gqVKuhdeDo8dxdBYulN6icUtuUNIfra+n24cSlEskUw7pfhtM/q8/TPcPkJpN3zHjqqXWqI7jWClyE3fEoIgIKmuGf8x6F6XB/ZZ0uxz7Wt3lAEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=gSHD0ln1; arc=none smtp.client-ip=195.113.20.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
	id D9295283B52; Wed, 17 Jan 2024 13:10:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1705493452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y+qkmuUXLxRNPYR9af2v6niFPFCL/vWgu8c9nVvlerA=;
	b=gSHD0ln1XqGhz9aPdIJxoluN09VJuAaYrlCOXoyAGA7B1vmpHy1khysOVqb4ouI2TQ6l68
	6Uel2ovd0+gXrl893AMAVYR/4ncWYESvzmliMpCqvgx2vpwWQErrGtfZ2O+aOaqCnEWRw+
	e0zJtQUWcHRaODZR03xKTKd+85YOYeI=
Date: Wed, 17 Jan 2024 13:10:52 +0100
From: Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To: KobayashiDaisuke <kobayashi.da-06@fujitsu.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org,
	y-goto@fujitsu.com
Subject: Re: [RFC PATCH 0/3] lspci: Display cxl1.1 device link status
Message-ID: <mj+md-20240117.120837.23579.nikam@ucw.cz>
References: <20231220050738.178481-1-kobayashi.da-06@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231220050738.178481-1-kobayashi.da-06@fujitsu.com>

Hello!

Sorry for the late reply, but these days I don't read linux-pci
regularly. Please Cc me on all patches for the pciutils.

Anyway...

I don't think this is the right approach. You poke things you shouldn't
in user space, you also make some bold assumptions on endianity of the
machine (you are using native C structs for data provided by the hardware).

This belongs to the kernel.

				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe

