Return-Path: <linux-pci+bounces-1958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06084829131
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 01:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C0991C250A7
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jan 2024 00:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFDC18A;
	Wed, 10 Jan 2024 00:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/Qa3jQh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11779182;
	Wed, 10 Jan 2024 00:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D54C433F1;
	Wed, 10 Jan 2024 00:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704846114;
	bh=gGBxlJSlNg+HT+kUxK4TBKVg9fAdjhFVaiJGQOyoLKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=k/Qa3jQhzuR++vA4wt7WgyP1urHFGxgjYhS3UphugiSjRLaj5SLKGQwpX4l21msgN
	 tShbyt1lfmRc/VdmPt0NEFIR9Xi0Z4jpX7/Znts3Xbwv86/+7eGbsfMziGgDdJgMPb
	 eESHfJCW6XyIg7jE1fsOO2ayqUNKOnBtuaOqrpmzCYm0NwCYvOLz3Q4xMwBhf2EN9F
	 Kv2FWN2YWj8LXk2y7HzoSuHhzhLkjK7dey7sHPqTfMzjEl1I6bebp4JTK9+Rd+gQ2g
	 yJ3pO+FZ7R/CHunWLvGCuvKWdGpAq9sMt6bgEL2yLqorUk3bmmoJEep1dPi9fufLkR
	 K8KVC2Rw38UUg==
Date: Tue, 9 Jan 2024 18:21:52 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v4 0/6] PCI: controllers: tidy code up
Message-ID: <20240110002152.GA2085796@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB5341FE0273707AAE4A9F92E7D86A2@TYBPR01MB5341.jpnprd01.prod.outlook.com>

On Tue, Jan 09, 2024 at 01:34:54AM +0000, Yoshihiro Shimoda wrote:
> ...

> Now v6.7 had been released. So, should I resubmit this series after
> v6.8-rc1 was released?  Or, would you resolve the conflicts for
> merging this series into v6.8-rc1?

No need, I think this is already merged in the PCI "next" branch and
should appear in v6.8-rc1.

If you take a look at
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=fbfdb71c8c79,
you should be able to confirm that your series is included correctly.

If it's not, please let me know!

Bjorn

