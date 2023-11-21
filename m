Return-Path: <linux-pci+bounces-65-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DDD7F3856
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 22:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AF38281211
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 21:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF30584E3;
	Tue, 21 Nov 2023 21:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfTakCdQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C691584C8;
	Tue, 21 Nov 2023 21:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC73C433C7;
	Tue, 21 Nov 2023 21:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700602335;
	bh=X2pX6zjIezmOphz2fsepwof1up+Wj7drUJ9WUWnm88s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QfTakCdQV8fvOFgAXcIyUOQDs2rJgK2uOSKu59J3XdHZ2v2BCwE10Nyfc+vv8aalL
	 7K3Ok6GSc6zNsvLmOLMRYi3ur5ch5bduBBWpcGHd6BAit8h0XdQo1VB5xCmKjiViEY
	 KMxirtK1cKoJaLO+fkC4jTlZGU16LmuKN3jla02bswEb3F/k9JH9zfpXrrLmycnGKn
	 urKheLGBEKFmGXyxhVbQVS3TtWCSBB9bb3VbFq53B037iLlzAQlkI+9Sh5uJE0Lh9o
	 pekgOsGoM2ML7SzaLyWYUudKG+uI5pCfqx9nmdxtKoSL69Kur+83dlGm0qQ2/51j5D
	 2VXyhh0KFGNUA==
Date: Tue, 21 Nov 2023 15:32:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Conor Dooley <conor@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v11 19/20] PCI: starfive: Add JH7110 PCIe controller
Message-ID: <20231121213213.GA258296@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad43c202-3796-469c-b7fb-7591026e6888@starfivetech.com>

On Tue, Nov 21, 2023 at 08:52:21AM +0800, Minda Chen wrote:
> ...
> BTW. Could you give any comments to Refactoring patches (patch 2 -
> patch 16)and PLDA patch(patch 17) next week?  Thanks.

I think Krzysztof or Lorenzo will handle these.  I skimmed them and
didn't see any major problems.

Bjorn

