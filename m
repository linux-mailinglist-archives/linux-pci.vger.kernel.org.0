Return-Path: <linux-pci+bounces-11956-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34192959F37
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 16:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFB0F1F23095
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 14:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D027C1AF4C8;
	Wed, 21 Aug 2024 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ok+GK9N/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34301547D4;
	Wed, 21 Aug 2024 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724248984; cv=none; b=gk53P0DRHQ7yCPkf3zx+J+hKyWLdaqhPNMpaqTW47ovSJNCxf488AsZmqeJd6cEUkJEm5sFI6MiC6ojVrFi32FdguZd0uFN5GOdWXCENWYX1N0RYgmY+goWizFuMyuShvGiGZw3CPwMdaSfpkWD+ovMlk+sS4UuxHXyk9ifk8iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724248984; c=relaxed/simple;
	bh=9KQt3Ado5lkN2Lksrd2Ub8gjEvF2dK2WAnBhcopjr+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXD0ndm6e4hzY8YVxl6UJJEIakLPNUIxQUSmZi7wS48r+UArB+MvYKA9Vt+ZPd1a91NyoUbJ46TnlFIKObXb4R0ByahArSy2wDoPoXxoUydf4Tuk3ftUmohvQGx7L7PEZxDd4jiGwnNReyKytAMCiuhX/8xXT8yWqP/0trDHzlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ok+GK9N/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE17C32781;
	Wed, 21 Aug 2024 14:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724248984;
	bh=9KQt3Ado5lkN2Lksrd2Ub8gjEvF2dK2WAnBhcopjr+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ok+GK9N/CtzNxjWbIT1N2J37JYaQQpvcajh02jWoH1ccqMk/D0O5DbMFeJk/vvCyo
	 bz4e2p46FpXD037CMt4mPNrTYbhjIDzxS9IIgY+EWSJRSHC4wjCj8kbUbburaGF+rS
	 1E9+yngheisHclzDgobzWnXEZ0kGaMswlI1oSDTBZ5uLdnv53ezQk8STgrq3rxSqA8
	 wpYuMgMtNuJQ7CvD5yUReheBkcLcnZbif6HDP56ATo09yEIpfES4exHbn6yT4Hg0SR
	 TUFaDYwTRbRC7w418J0MIKF1qq3Zvr3QhxYCluSM3koVKLaGfaaRvmtPRBlRXlAJ0d
	 isiiWjZQnGbFg==
Date: Wed, 21 Aug 2024 15:02:58 +0100
From: Lee Jones <lee@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	Christoph Hellwig <hch@lst.de>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Keith Busch <kbusch@kernel.org>, Marek Behun <marek.behun@nic.cz>,
	Pavel Machek <pavel@ucw.cz>, Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] PCIe Enclosure LED Management
Message-ID: <20240821140258.GA6858@google.com>
References: <20240814122900.13525-1-mariusz.tkaczyk@linux.intel.com>
 <20240814202751.GA359905@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240814202751.GA359905@bhelgaas>

On Wed, 14 Aug 2024, Bjorn Helgaas wrote:

> [+cc Lee, linux-leds for comment on using the LED subsystem as
> described in patch 2/3; would be nice to have a reviewed-by or ack for
> this.  Thread at
> https://lore.kernel.org/r/20240814122900.13525-4-mariusz.tkaczyk@linux.intel.com]

I usually say things like "if you want to act as an X-device, author an
X-driver and put it in X-subsystem".  However it looks like the LED
class is already heavily abused in similar ways as this, so there's not
a great deal I can say about it.

-- 
Lee Jones [李琼斯]

