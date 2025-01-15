Return-Path: <linux-pci+bounces-19869-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F481A1224C
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 12:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596EB188E54D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 11:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55AA1ACE12;
	Wed, 15 Jan 2025 11:16:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9A8248BAF;
	Wed, 15 Jan 2025 11:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736939773; cv=none; b=aMrXUdQFxypyrj1gStI5XpDpTrBF3UgjewemDgyTxW0FfMgN296NNh0XLrXYh/idTMI08czGAfljIvp6o0oXM585FAh7Pt+CC4NKTZH3WwmGHhI9g+gyJvaSY4l7ysPMOyQzWZZuUnIA8a6G5osxStbswfiBSoblPyixL6Qo/PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736939773; c=relaxed/simple;
	bh=/ICypvn5kuoCF/EyNZm3QbxKGYVHsRrfP0THiYSMp8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENni9WttuwwL9vyYkMNMLXgQtlFkzsp2XHyUQOj8leUnfcgSyCjtAj+pFXajmOcs5GXJSnBdsWLTrvDXk4I9O40WTdtLQM7qJXnQg0dxPpYmwJ5ZWQZWai0SFIhIS2bxss6FF/pnye7maDy2RU0uAK/GMY2J11fVvxrp8UgsUU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2166f1e589cso141894495ad.3;
        Wed, 15 Jan 2025 03:16:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736939772; x=1737544572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Kw67OIBBLmEStPVTyogH0wxEiR1fl+xyxzlDKAemyc=;
        b=SxiwuMGmzE/ecu+M4jScLD5p73A01UD7e63D26WG1zuATjKUOYqfFsArxSFg+D26NJ
         LZzDzqCmjm2jZttVuc7LyP3gTmxGwwffMn9o9pBllrsZVHG5cPK0ig6S78dbKhlxOhBV
         Vhx9KUl0r5sKw8lWVi723iZl6/s1iGDmZ5AZ3x+dq6gyeiIVvv99DYliC3XQFGzZw0j+
         C17wjmu9ZqGZygn1PDOO0Pwme44w9PD/LpxNAYUtmramiG+JjeV706BfFKxvtiFTUJaw
         V378dXcvCaNUhKTfHO5bUhvvfgZiAb3H329UdyO8DUCm4yDdFECzV3TSvc09rW7+kj2x
         yITA==
X-Forwarded-Encrypted: i=1; AJvYcCWCZsma2g3SrYMrgfxHvmP8ErcYJt7vBfkRzxw06UofTOCqE6oMuvNMtiYpJFJ8n3XX9ngTz4KyKW8zy5U=@vger.kernel.org, AJvYcCWYO6dQbshSX4dcwygCPgBPLm07o46P89kRp1Y+zfH+rk88ux9izz6xlrAUssUGkxsLUh8UOzXt/iSk@vger.kernel.org
X-Gm-Message-State: AOJu0YzWg6NzyPhMANoQ5UNytNESr5Hd4TWvG/P+jqQ18WhRW5cGb4WW
	kxmAWX8FrjvrmzV2YPkc4PhhcQZgP2blVy4Dydi4EcnGwrqkNWAB
X-Gm-Gg: ASbGncvE2bRLJcE/MpQT97aKFLE/l35JErmd279rs8ACrGS7rR8bUJQ1duqVimgQ+UY
	WkAsWJhKspK9rNSe2hd5Ia4Fwg+Zn7aBvb6QTYHulbmaXzSi5/vI1PsYtChs3R3hNhvvtynZMj0
	UzoJUfXEUDKWVz7HaGaOUdeKmYQJ9BweREwp4+4Gv9PDFWCwtjweC+aRNt+5DCVMUnSFbINPl8C
	xpMktmhlEL3/QKh43I2PjgZOD5uUmvO2JiLDRPOgT4Vnz7lWRyS6I+BobJb3hWdDrKHQ8y2RUxq
	RAqMflOAj7SOp3w=
X-Google-Smtp-Source: AGHT+IH5OAsVS2PlRnMNk7lD8elaMdkqgDDfyGz9mjd0ExeYOdTBcE2chmXF3h2Tj1xi3fzo5sfr5w==
X-Received: by 2002:a17:903:191:b0:215:a964:e680 with SMTP id d9443c01a7336-21a83f65330mr424297155ad.25.1736939771781;
        Wed, 15 Jan 2025 03:16:11 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21bb316b825sm51658385ad.237.2025.01.15.03.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:16:11 -0800 (PST)
Date: Wed, 15 Jan 2025 20:16:09 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Douglas Anderson <dianders@chromium.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: mediatek-gen3: Enable async probe by default
Message-ID: <20250115111609.GC4176564@rocinante>
References: <20241220145205.1.Ibf2563896c3b1fc133bb46d3fc96ad0041763922@changeid>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220145205.1.Ibf2563896c3b1fc133bb46d3fc96ad0041763922@changeid>

Hello,

> Like other PCIe drivers, the mediatek-gen3 driver has a fairly slow
> probe. Turn on async probe since there's no reason to block the rest
> of the system.

Applied to controller/mediatek for v6.14, thank you!

	Krzysztof

