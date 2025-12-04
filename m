Return-Path: <linux-pci+bounces-42598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05697CA21E7
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 02:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 154EC30358DF
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 01:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C9B242D7B;
	Thu,  4 Dec 2025 01:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ItWbvHj2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA7B242D70
	for <linux-pci@vger.kernel.org>; Thu,  4 Dec 2025 01:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764812459; cv=none; b=s84ENie5tomQDh4rycqVbBYnxoJAFG6MTzNrjRJf1kSUqywOfniQ52d64jeSEQq50zVnC5E7/f1izgZ/yn9Z2HpT97hCqKpLGWol/vyxddhj7sFWUwlzvSNilQoYoUK0TQi39fkqoFuiwWGI08j3UbWOFmYam8TXEnyH+ehKC9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764812459; c=relaxed/simple;
	bh=BM99yA5zKxdKG26bL4c4KmFejVDQUbVH43COraIGd8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cV7PVsPfWENI5QSXfGBh7y8l7vXWDmakCRrwpY32H2IrxD11UgPY1V7wRktW5URD7+RSA/H5U8/8gE0k9/ZFNtfyIcyiffpFUIyV/FCtfFuNlG2pqLOHyohWb4/YJ1oASSTfdM4tHB8s6x+NsSxLEadsLHD/NK5IQPQUG674gX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ItWbvHj2; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640c1fda178so655585a12.1
        for <linux-pci@vger.kernel.org>; Wed, 03 Dec 2025 17:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764812456; x=1765417256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usCVZbWwv9v8DM+VA7vraEXPn/PrzYHVW6BELku9usQ=;
        b=ItWbvHj2XKNJ4cj3LloXOXDRuwpyjjVNC/OfMovOWqOaZOcJbVA7idkL1KRx550e7q
         zO/F5ZlH6XKjkjNW7eSeQvY/BT2JItibpGrOzAxiLNYDTHK58yebXLaQLhcC/DGNDX5S
         i3ireRa/fvbN0N3dPSvUYRcnOlHXrqHAd0MH1gbtFW1TVQYgEclJ3ISdsU9C957spbZB
         B05XxbNwIqJ8B5QacCNwBObU5n6CjYqNtbNVdVLggWbgi4SSVO4cp/Cx88SOARuF64rD
         5dT+X5owsHjteIsOU2ua4zbjQKxCd4TtIa0ChI8ErlBJUK9CbgWaMYuM5jmZLP9EkU07
         iBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764812456; x=1765417256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=usCVZbWwv9v8DM+VA7vraEXPn/PrzYHVW6BELku9usQ=;
        b=Op7Ev0JKRhwmLGWwUWiWe1f5cOS80P4Qbqd2D4N6W9jCetdfqt0nww/ZQoS+3elWjn
         6VNXpr3iFAg532LtmtsHYyGLMAH/MJuLeV+d2xGEGP80iWY7Ii1zN+fndAsxeXrpNvMG
         P9PC059PRo7IzxMIYQ4j+uyY583M+D9giSNVvrdam271OFq9ntaYx8zLpTXpmuARFuw3
         cPagLB2UTTkg9mgTiUVOTXurU+GXKQkPW6XnFx518F+RZq24scA5O/xY19XYuXsmhsJY
         mg5Ke0bIEWGyXsxfAL40ISY9co/sE9q/YNmMg4arB6QJdv9G/i+a19ndEqUkNCz/uxEZ
         NSIw==
X-Forwarded-Encrypted: i=1; AJvYcCUcicMiC1Xlsxl4ScyiLPx/rUkiWB2o8wj1oiuy7YoZynL1XXD4oCM7d6tyaQXg6buDvGq7/grVzXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YymjbtRZFsQTWMU+aza96pFtNVHn3/wlWdExSAFWQuwjqo8J4wQ
	y2m/8KHfKNJgftL+gprCuDyYVwybPFZBGNCPvEORTfV8E6qPs36CrMMbUhJPkyHzeqw=
X-Gm-Gg: ASbGncuwZuTPJlJc18Ij4IN5hMUIfKldfZJ9WzLgAeOkTdcvIEocGAtBLSR6t0zBUf6
	TEoCQSXcEde8susXd0Dl0xRSsewwB0+waJ4NQbnQz+801zKwRLLeSy2B3ssYnxEo2crvP6YDJga
	6hCgCQ6zrDYQXI5NrV8D0zuhbM8gnwBpKdGq6MPM8RlY3Tfb4ueTPD1pQAYF0fr3eRKvExsuOvj
	pa3YjIDriw29uWU6z8WzMqhVh2p5AUh68je1lv548SGsLj9e1H6VupyUk/tNbuOCP7XmCLFUp9J
	koqPXWzG2Udv9L1kYmpiyOeir5tw1Fz9YbD6jSBrVS6Hf19ZNVfWK0sTdmrb9R98++XOhCvB4aD
	HUTi2W88K69zvlWJICqbCy1YrA6a35RmVw044lcWiXq/7sPhHcWFpkGSM4sAf89n9fkrNiCxfUV
	lzke8EjFuXsoqu1aMjTFJuKR6SK3qusgImas+MTzdu/6NYO04=
X-Google-Smtp-Source: AGHT+IGfRE0y5OoQoEAxk9F/9R4hL3hkUmJWKifR9VWkvr8jbHYDQJhShb60/e1UsyObLpRQHJd9SQ==
X-Received: by 2002:a05:6402:2749:b0:63b:f22d:9254 with SMTP id 4fb4d7f45d1cf-6479c516959mr3524977a12.23.1764812455779;
        Wed, 03 Dec 2025 17:40:55 -0800 (PST)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-647b2ec3019sm80170a12.4.2025.12.03.17.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 17:40:54 -0800 (PST)
From: Matthew W Carlis <mattc@purestorage.com>
To: macro@orcam.me.uk
Cc: ahuang12@lenovo.com,
	alok.a.tiwari@oracle.com,
	ashishk@purestorage.com,
	bamstadt@purestorage.com,
	bhelgaas@google.com,
	guojinhui.liam@bytedance.com,
	ilpo.jarvinen@linux.intel.com,
	jiwei.sun.bj@qq.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de,
	mattc@purestorage.com,
	msaggi@purestorage.com,
	sconnor@purestorage.com,
	sunjw10@lenovo.com
Subject: Re: [PATCH 2/2] PCI: Fix the PCIe bridge decreasing to Gen 1 during hotplug testing
Date: Wed,  3 Dec 2025 18:40:20 -0700
Message-ID: <20251204014020.1426-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <alpine.DEB.2.21.2511290245460.36486@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2511290245460.36486@angie.orcam.me.uk>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On  Mon, 1 Dec 2025, Maciej W. Rozycki wrote:

> Discard Vendor:Device ID matching in the PCIe failed link retraining 
> quirk and ignore the link status for the removal of the 2.5GT/s speed 
> clamp, whether applied by the quirk itself or the firmware earlier on.  
> Revert to the original target link speed if this final link retraining 
> has failed.

I think we should either remove the quirk or only execute the quirk when the
downstream port is the specific ASMedia 0x2824. Hardware companies that
develop PCIe devices rely on the linux kernel for a significant amount of
their testing & the action taken by this quirk is going to introduce
noise into those tests by initiating unexpected speed changes etc.

As long as we have this quirk messing with link speeds we'll just
continue to see issue reports over time in my opinion.

