Return-Path: <linux-pci+bounces-860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB44810ED0
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 11:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE515B20C88
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 10:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A63922EEE;
	Wed, 13 Dec 2023 10:49:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE41B2;
	Wed, 13 Dec 2023 02:49:32 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 0B3B128042DAC;
	Wed, 13 Dec 2023 11:49:31 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 004AD231117; Wed, 13 Dec 2023 11:49:30 +0100 (CET)
Date: Wed, 13 Dec 2023 11:49:30 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: bhelgaas@google.com, baolu.lu@linux.intel.com, dwmw2@infradead.org,
	will@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Haorong Ye <yehaorong@bytedance.com>
Subject: Re: [PATCH 1/2] PCI: make pci_dev_is_disconnected() helper public
 for other drivers
Message-ID: <20231213104930.GB31964@wunner.de>
References: <20231213034637.2603013-1-haifeng.zhao@linux.intel.com>
 <20231213034637.2603013-2-haifeng.zhao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213034637.2603013-2-haifeng.zhao@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Dec 12, 2023 at 10:46:36PM -0500, Ethan Zhao wrote:
> move pci_dev_is_disconnected() from driver/pci/pci.h to public
> include/linux/pci.h for other driver's reference.
> no function change.

That's merely a prose description of the code.  A reader can already
see from the code what it's doing.  You need to explain the *reason*
for the change instead.  E.g.:  "Make pci_dev_is_disconnected() public
so that it can be called from $DRIVER to speed up hot removal
handling which may otherwise take seconds because of $REASONS."

Thanks,

Lukas

