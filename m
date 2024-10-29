Return-Path: <linux-pci+bounces-15533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8377B9B4CEA
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 16:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC8D1F2462E
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 15:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A196621;
	Tue, 29 Oct 2024 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwNeXOzQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C08F1591E3
	for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2024 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214324; cv=none; b=Rqdwu9lwkFBDYlDC6NQbSKaHhMpMn4nwKpWLTVwxyDowzzyjgekWm+ncLhHCeVSGvjWCJLWQzQg1YTDqpdh7GqK1UzLZ4iiolIzzbuFSyNIyAOeDVEwLz+Qlmub+CdLxL0ZsrrAe5e4aX4aNwBHf9dLwLHXDbLW+K1dWnWNcZzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214324; c=relaxed/simple;
	bh=VFNtCeaMH7J7+ApXTFw02jw/rWQ0ESNCc79WWkj2+w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1Lltfpb4ldm65H4gOrrsBD/jFNgYd11IcQN3tEk/g/5wGbfqMz3dgGGZ/byT3I3lrbuso7YjdYcMH7LSKU06CJViCcXnRdFjRqJUcKKVPDch8BSLGOnVwnaWgTOh5E7DgZsQQCTuwsp7lcVxqNLDB9/MqpwEvHaVzU1+CjM6lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwNeXOzQ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a0ef5179dso817063666b.1
        for <linux-pci@vger.kernel.org>; Tue, 29 Oct 2024 08:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730214320; x=1730819120; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VFNtCeaMH7J7+ApXTFw02jw/rWQ0ESNCc79WWkj2+w4=;
        b=KwNeXOzQGxieDWM81OhylVVHoJ3/rtmN/SdZfEduhTvhbpKOgFDIhYXLgq43sGOfXn
         gcNHVhOezOgdtD5HHO6Fi/2TiW8EaNhpUNbTyVDkBstZUlR+gkWw9ZNm66rp7lqAThdq
         bQs0u+iVK3hFxiIsD2LIIgDzKhsKv1xDOccSmdwCetBymuElQ4QJg0BC2x4vwMIB0xH4
         nVbib6Mq/zI0Kz0lUVOWfAJOYVo3KsLunXVyepib15Aib+5ebdlsy+UIZZ69GNAM03oQ
         hu6MLW/oP2gPvrJlwN/gA/ZEZFQpD5cTnKQ07NA79e0V0/MeeLSe44FBoRvm9PBxVaI7
         1A8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730214320; x=1730819120;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFNtCeaMH7J7+ApXTFw02jw/rWQ0ESNCc79WWkj2+w4=;
        b=EyxKRWA2tLjHG+hMy0QcoQygLFsM6dtr4R1+QSs03NYaSAPWlEeg+qLeXmO4w9GtDY
         vssQxltt3WSE7Xa7/1GgsYskEmOzRBdvUcfcABB9HLOnKif8SR6dEtzIbcq3sqnK0yUY
         CxwjCfYUwrR6W3qqq8psSjf/066yL6SE0zE12adJaEfzAwpUI/fy+PSO/7wYza+orEN9
         Bvw55G0gzUbmNGUijoeTTkBiw4OUMEbQKuNQaLlzy5prYHvEwJXVq8yJo0QROPWueKQv
         yVj5CZl7U4mqif5oFOi5Hyop4HIGoGSfuAjKM7+X+RUx7f58tDzMiD2t/o86iM6JDYFp
         vhmw==
X-Gm-Message-State: AOJu0YyBLV4NJkrc9+q8X0EEnh2Ge1DPryP3x8YJgsJq4uz/09MxWta5
	hZnCbNl2OY+un2AdbslooNc24gYbj2/tRcYPkf1rXX3Wwn4Gfpsz
X-Google-Smtp-Source: AGHT+IEXlzS4KxJwKTefb3kYH073tuJ8udJp8+eooLUjeVJsI656iZIJI0LCBbxkjuh5BSQhH1Pc0Q==
X-Received: by 2002:a17:907:97cb:b0:a99:92d3:7171 with SMTP id a640c23a62f3a-a9de63327dbmr1202234666b.61.1730214320307;
        Tue, 29 Oct 2024 08:05:20 -0700 (PDT)
Received: from 147dda9f5b00.ant.amazon.com (dynamic-089-014-183-103.89.14.pool.telefonica.de. [89.14.183.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9afcef10efsm480435266b.0.2024.10.29.08.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 08:05:19 -0700 (PDT)
Date: Tue, 29 Oct 2024 16:05:18 +0100
From: ameynarkhede03 <ameynarkhede03@gmail.com>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, 
	alex.williamson@redhat.com, raphael.norwitz@nutanix.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 1/2] pci: provide bus reset attribute
Message-ID: <wooy74xjgkil2lyhvxdjosbepxvjc7sgq76rtkld2i7mz4p6k2@37yzzkec5f2d>
References: <20241025222755.3756162-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025222755.3756162-1-kbusch@meta.com>

On 24/10/25 03:27pm, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
>
> Resetting a bus from an end device only works if it's the only function
> on or below that bus.
>
> Provide an attribute on the pci_dev bridge device that can perform the
> secondary bus reset. This makes it possible for a user to safely reset
> multiple devices in a single command using the secondary bus reset
> action.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Amey Narkhede <ameynarkhede03@gmail.com>

