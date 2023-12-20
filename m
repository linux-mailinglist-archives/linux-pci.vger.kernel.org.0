Return-Path: <linux-pci+bounces-1224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9D581A2FC
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 16:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90C161C238C0
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 15:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5881D405E0;
	Wed, 20 Dec 2023 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEYyiChK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BB04184B;
	Wed, 20 Dec 2023 15:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78727C433CC;
	Wed, 20 Dec 2023 15:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703087198;
	bh=buZ0uthUYg/dZyPy0gNLv1TA78g0kvvXHVubL+0C9A8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gEYyiChKiGUhQOzrJvhu8y4wokWx+pYf58ADKKE9Zq8ze0yXFbXRvgB6SWALtRGmH
	 hzUN6BTKJOLTuJi5N6wMde2HGcvGb9gyiyHd9rpbuh6pOmozUyDYyAnM00UNvs7upy
	 F9mKBjiBg4jzl12+R/fMRrrjg7e/BMhVj0gq31IP6ODLZFvA86iXRGtkJIJgG7MTlC
	 kd3qiiqEWTfWVLWV9RXqnwCvMEHOIYTIo2kAGe10ntd8WTOzBSQNxHBsYSinlz7reM
	 OLRxKDXiNBhq/FCB2orTzJN2IjECjOctNDtzBqNsU5DTctbY3GbzPT2PKB3jjwVKkY
	 bDg3l58Gm7mAg==
Received: (nullmailer pid 269252 invoked by uid 1000);
	Wed, 20 Dec 2023 15:46:35 -0000
Date: Wed, 20 Dec 2023 09:46:35 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: krzysztof.kozlowski@linaro.org, bhelgaas@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com, helgaas@kernel.org, hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org, kw@linux.com, l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v4 09/15] dt-bindings: imx6q-pcie: remove reg and reg-name
Message-ID: <20231220154635.GA266754-robh@kernel.org>
References: <20231217051210.754832-1-Frank.Li@nxp.com>
 <20231217051210.754832-10-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231217051210.754832-10-Frank.Li@nxp.com>

On Sun, Dec 17, 2023 at 12:12:04AM -0500, Frank Li wrote:
> snps,dw-pcie.yaml already have reg and reg-name information. Needn't
> duplciate here.

It does, but it doesn't define which of the possible names nor number 
and order of entries. It's primary purpose is to stop people from 
inventing their own names.

Rob

