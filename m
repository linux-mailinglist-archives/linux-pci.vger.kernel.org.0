Return-Path: <linux-pci+bounces-23093-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E3EA562DE
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 09:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11C551709B6
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 08:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482FF1DDA00;
	Fri,  7 Mar 2025 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S7l5sUCk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867FC19E971
	for <linux-pci@vger.kernel.org>; Fri,  7 Mar 2025 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741337197; cv=none; b=a6Q1UvEv/n8nJN4fkg2jkYfX/FvhRFOCBi/UuXP6TDwxXagM71QELajzHdPjnOMV6Uowxbya1lhPOt/HQKHqC4Sn5yIdFgA3VnJn8zBlZ+OWe/UXt2HDoGjLjukp7Fa+eND6ll3fICPAjzOT+XrBLs5C4QVE66prhmULHaRZsdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741337197; c=relaxed/simple;
	bh=UZdNPSFkGuF67Y2D2j1l7ajtTt0384qJziCThvH/X7I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qDt4UynmXOcQZrIlMYc4pEWr/PkuqvBp8y6SFiF+px35IKqo9E9crnykbRoExdfc64yAXyjpekA8OcyA3UmZ3wd44m/8QcoaexrwmM/upvB1N9CUFKDr7P8gaMRVWHihVAChf0ydpp164nedAikN1py1MMCPAfz8i1nsXtJDjRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S7l5sUCk; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-390e6ac844fso1373311f8f.3
        for <linux-pci@vger.kernel.org>; Fri, 07 Mar 2025 00:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741337193; x=1741941993; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YpjTC2Zowt+/mheAT9bBFuVRKJP6ih9w+W88EZYs/AU=;
        b=S7l5sUCkDUQiyrIqZKdlq+5UbK9F+1pteNriXVLIqTNC14TEjddENAWAijZBbFDXqF
         QJM2s/RdbZKsfKfUEcb93LFBmYycVW5SnBesznTPFl6vPR9bVEFWYOtkvclA55BfuyD8
         NWDOJsZabzHXc877m+FaUucUp0MeSHsXRclNIkNGwpoaxn37IWgra0/R1fKDUwZoBbkr
         740/j3gX85cnSw20fbOXLQWQ4SRTS9wYRMT2QJ9atOTwAdCOOzEj3XEblvE36TUMIfoj
         B1uqUiMluXPz0DGXRzy2CfgZ8I1bhXhWE8+En8m+s6zxvhPRZ5/aq+jy2eQkYzuZlre1
         cs7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741337193; x=1741941993;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpjTC2Zowt+/mheAT9bBFuVRKJP6ih9w+W88EZYs/AU=;
        b=of8WchzyjXlki6j7c8KuY+RsqqZ59jm1cA+qSuyou3EwDFavx8YPDoK6fQTeu5/cZJ
         FXXJpLKV2EIoGiLTy14zvl9nX1h3s4Kk167aNbZcoylWV2ikwwhJWOdqEQG7qV0wjOdw
         xfDJ5zRDbPx6oqkAqCVG11thekdmGZNLW9EmIISBxFoOHqh7gKbymP1EvIDfA7Yq0q/x
         1PcFrwiN+/z1YV511PmSrVMnfi3fkWGj6D9sGaTeKq/ar+tPKOYocxzqFgO6glYj/hJM
         MbSkw3W0ICJp630Cl17t3BgpeVXn8WsDoqZgfAo7yvPEYTF91071PvJFIk9YQbzvwIq4
         6e1g==
X-Forwarded-Encrypted: i=1; AJvYcCWGkMwJYRQLr+HEzIHON6nSTWxdcKxHS/yaEMubePlUuSlKJty/GD+gyi13zQpGU3srCJZgfTwYJMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YysMEGZNWCTaP7K+zN/KvtCIzI5oZDMtDs9N87evAjFyAf6oslI
	/Gq0WCbkwOyQ0/w7/MPmq4AfhkEg51tCWzPApK2giyl8KBut7jpNTI7Gzxtu3o0=
X-Gm-Gg: ASbGncuE9Vk8jSog3UIy9+beHXCusM6i5lc7jMvGyN2xIKLdIvOaD99X7LQF2wYYFG7
	tEt/sOOrALcN31bjBUwnXF3OnbjUd7ZkVzYGSUQQuHU7pckwHuZQ6tnxDzlm4GzA7sgi1dMtdO7
	N7ca0RLmRzB7PSVGxrAokjhiH30RnmEgGasOgIwV09zA62uRpHahg+ESH3U5pJl/AQt2H182lXD
	/sVnyd5hzzEakKT3VtEXK6W+8tqW9Pu+04HooibH2EpI04LVZH1+ni7n+GZaExS9FXH+JZdhnAX
	nYonbNDT8JBqOW/RePV15wT4UWwctX9jzU29j/j/OLjEL/JT3Q==
X-Google-Smtp-Source: AGHT+IE2WPmmMHuLMoG6nFgev4JSV9g1QQICRRmhZKcc7TCsnVzPPzO+2yO4IWmx2AdvpgYXNQ8mQQ==
X-Received: by 2002:a05:6000:1445:b0:390:f738:2467 with SMTP id ffacd0b85a97d-39132d5a94fmr1699978f8f.33.1741337192832;
        Fri, 07 Mar 2025 00:46:32 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912bfdfdb9sm4606948f8f.27.2025.03.07.00.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 00:46:32 -0800 (PST)
Date: Fri, 7 Mar 2025 11:46:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 0/2] PCI: two fixes in pci_register_host_bridge()
Message-ID: <2865c3d3-7315-43b2-8e3e-5eaa6a943f18@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

These are two error handling fixes to pci_register_host_bridge().

Dan Carpenter (2):
  PCI: remove stray put_device() in pci_register_host_bridge()
  PCI: Fix double free in pci_register_host_bridge()

 drivers/pci/probe.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.47.2


