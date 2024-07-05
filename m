Return-Path: <linux-pci+bounces-9837-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B989928923
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 14:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589841C20A3B
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 12:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D5114430E;
	Fri,  5 Jul 2024 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RemcqUjs"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78B213C8F9
	for <linux-pci@vger.kernel.org>; Fri,  5 Jul 2024 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720184341; cv=none; b=RU8owlKr9Zg2Kw2F7RKAbuTxahpERFglUoIU0+q+aGN7jh34yi/yFC+DcvgsA0PsW4UnhHraXsavW4Tyd+BnUeXk8Ew2lZ1MuSizdjLB2tr1dOSGPo9R0OClXuPEg3WuTF2kdBqb2l5HG2IpQ8U5bfg9J+kdWOB3w65n68DuHfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720184341; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ms8EQIJBzf7zl4JqwJ1wZBnW8F4BLhTBaKxVhQXY37JAFBqzjY+AkCgLrFIBlU7n1WwF7e3vpczxGFGkPM8Jm5xLkPR8CW9ZkG9SIGrbeQ1AxseitCZSv2ekJNRcnUIraruyolQs9pag/BCdo3XYi65VoCd+LZz5JifFIggQqZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RemcqUjs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=RemcqUjsz4lxTi/MBjvyF5GvQH
	Yu+oudQQ4kVoQLrleqYaOB8Idpb1TJ1+ZM8xASpbedcQPqr8meEmRk+UZfyX5X9Zsqj7G+tainod0
	I+HCI4XLxpMnjDQkcIgSIdjpVfRNc3AM/bpksKrD8ggclMNfV4ooU8ESSdwIst0xMFJQb/b/a91ta
	W5VMocFzzn5Fytm8gDvHQepmrDA0RYjavZ008k9IgTe5+hOzIyM9BAksiDGhmrp9OzSNMiGVtrb9K
	nu72fT4GeiIYEGS+VRGexeJNqRTnHJzFj8ZQe7yto0X0RUkwk5bnvwaglci1wVCntMxeM3w4mVBW6
	VyK4rHuw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPiWf-0000000Fyjc-3v5P;
	Fri, 05 Jul 2024 12:58:57 +0000
Date: Fri, 5 Jul 2024 05:58:57 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>, Keith Busch <kbusch@kernel.org>,
	Marek Behun <marek.behun@nic.cz>, Pavel Machek <pavel@ucw.cz>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH v3 1/3] leds: Init leds class earlier
Message-ID: <ZofuEd46ps7D9K01@infradead.org>
References: <20240705125436.26057-1-mariusz.tkaczyk@linux.intel.com>
 <20240705125436.26057-2-mariusz.tkaczyk@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705125436.26057-2-mariusz.tkaczyk@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


