Return-Path: <linux-pci+bounces-15998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2CB9BBF03
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 21:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E2D2B2185B
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 20:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D35F1F7543;
	Mon,  4 Nov 2024 20:48:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A061F7547;
	Mon,  4 Nov 2024 20:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730753320; cv=none; b=QiWk4R0KP1QFi9GTQ/HIwKDOU0V1ILc3r7ksIV45Kgv0dLzC2bqvl/e0g/gO3+uWwtlCULydY6aH28qRrmzoeRLhLZ9+l/sqRht1TgzPdI2Fsnlcyyuk+KBuDexilmat/OeV8JB7Q0Bn0z28d/xLi8KX/zx39kQsS+Tv9Tx4myM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730753320; c=relaxed/simple;
	bh=VaqaM023lhEKbr7Y7rD9K+Ec8+G7Ce3Hpvo6c1CTAPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVy9ZQynhzU4oFbQFmJn3jm19DmeLU3czf2e59r6bFzQe96PYcthILpnwQ/HAjA/wl2rppvtYmmfzOrM8BSFahxgAWO0YzHtjYXVa9HwPoisowLYnQU0hxBneUYZKsioW6A8S8uWI5R1TzOQu9tYWYn4+oIabZ++bkW76ZRKbxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7203c431f93so3983984b3a.1;
        Mon, 04 Nov 2024 12:48:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730753318; x=1731358118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vBKcQx+a24oOYGC6Ct1dCMKy+5lXC86wL5OdVFwb1o=;
        b=l7XEzLjShTO9InlrUpVMw9EHH0r7HZlNabxQtGOk2zDMfwzuyC/EUorhGbwS9zvgZf
         I/dmrf9rqL99SkASUyJ2bCExAMxWU9RnJIfdS2EvIVQThU/tH4oL8AEVY0K+0mXjiHGv
         cArRFsp4vyoxbSE3K7qSajtk3GPKnxfVkueyvTqNsFcwi6e5SuoD+8D7JOFJCgR0AE7B
         q9iMbfbX13Ah7HJO+U7HKK5aT8lFDEvl54YN/BAhOoIGJI4r4v579MszK+gqbesInfkQ
         TIhxZMtlxfvUD/N8K4DS9bMtSTJG9AvMpDp+VMdbucACikZeEjvErtBVVIrmBOmD1QX0
         Qxvg==
X-Forwarded-Encrypted: i=1; AJvYcCUetqudEQxTfKYOd73JjtUWaislgZ6D9nT09PJiPO6pReNvdb9UabD9BqyeoGf57lixVtBQI5lBti+5@vger.kernel.org, AJvYcCWc5GJqIcd5H/prdwjmOg/So97OJuYK2e517SJgNHhLYzmtrbhjb4C1w5rpWfBNtD+8+1PkIE4+n02M4BY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNlrmpzMOHpKG8NAerYvqWm9flKZl9oBZIu2GFIil+XDQhp40W
	O3PAuCLnCEK9sReRncb46InzaLrPyzz3VDhGp5KiE8MtcVRxiWO8
X-Google-Smtp-Source: AGHT+IEAVAQ2x5eEQk+m3dWGwSLaXPJKZ8NiC3Y118imnegOesysarCkdhwdiiKo3RWjRGAStZuxZw==
X-Received: by 2002:a05:6a00:190f:b0:71e:795f:92f0 with SMTP id d2e1a72fcca58-720b9b84653mr25117272b3a.3.1730753318533;
        Mon, 04 Nov 2024 12:48:38 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b892bsm8303361b3a.13.2024.11.04.12.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 12:48:37 -0800 (PST)
Date: Tue, 5 Nov 2024 05:48:36 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Use of_property_present() for non-boolean
 properties
Message-ID: <20241104204836.GA880663@rocinante>
References: <20241104190714.275977-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104190714.275977-1-robh@kernel.org>

Hello,

> The use of of_property_read_bool() for non-boolean properties is
> deprecated in favor of of_property_present() when testing for property
> presence.

Applied to controller/dwc, thank you!

[01/01] PCI: dwc: Use of_property_present() for non-boolean properties
        https://git.kernel.org/pci/pci/c/6734997ebd6e

	Krzysztof

