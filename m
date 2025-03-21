Return-Path: <linux-pci+bounces-24416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C095A6C595
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 23:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A9B189F55B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 22:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C801F12E9;
	Fri, 21 Mar 2025 22:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awNp+hwS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7E41F0E3C
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 22:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742594477; cv=none; b=MpvbQOJ4pCD+e4qRHxI/2VExJFy27NsVe0ztfpGbBGgS65r+djFIawywcI5ReQZEnGE4D6lFFmY6pTtA8eMKIQD0qVHbRp5TgYl+2q+zOPhpWzcw4hKJ3k5IVvUNbUyZI0OreBaZpGzqd6HD6d0V23UtQmFVKpC+/R4mjVUZv4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742594477; c=relaxed/simple;
	bh=GcsHBO4WXUZHEG2rucSJVBBxP58q5GuPErZu/SwFWOI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mblL1XfVq9VagB6429voWbDzACc1e0azLyEHd/Aqbeeh7Weaw75o4D1d1I5VRk4raGSC0KabjRG/RNf20ttj9ls+ayB43Csry7c30LsBaWysp3W51lCIydgcGGyXoZpR3oJ9uW9KCKW196BVZyMmkPTXhGRqH92HulUK1wOg3Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awNp+hwS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31729C4CEE3;
	Fri, 21 Mar 2025 22:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742594477;
	bh=GcsHBO4WXUZHEG2rucSJVBBxP58q5GuPErZu/SwFWOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=awNp+hwSrV9dWXyC/RxhlWYh8Cz8OxVo8aceLIWtPguuEfW8byJZuLePe2OXvqG58
	 dfPNm7obx4xg8dUQZ8wCeOR9dkjXdD1wHhC2zzKq7aJzbl1kF6B5CJrNg+jLdl026R
	 EZDH5arr38lQPno2C49sUyWOIGP3DaqY4lNpMMqJpzd/4wrg43T6WIBh9P19q3+u53
	 yRxzxuAgybhRLKCJ6x1lZfVCQAwOReCZKB74MQx/GuQMQaQsiHRkL+ioqIebft+SFV
	 es+fQZkbEabCOW/72nPqWIZfYSOnk8ImPxLjZQ4di+JSBdUwrOhSZlib7UC+8eeX9k
	 JNd1t8+wdhdtw==
Date: Fri, 21 Mar 2025 17:01:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	linux-pci@vger.kernel.org,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sargun Dhillon <sargun@meta.com>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v5 5/8] PCI/AER: Rename struct aer_stats to aer_report
Message-ID: <20250321220115.GA1170462@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321015806.954866-6-pandoh@google.com>

On Thu, Mar 20, 2025 at 06:58:03PM -0700, Jon Pan-Doh wrote:
> Update name to reflect the broader definition of structs/variables that
> are stored (e.g. ratelimits). This is a preparatory patch for adding rate
> limit support.
> 
> Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> Reported-by: Sargun Dhillon <sargun@meta.com>

What did Sargun report?  Is there a bug fix in here?  Can we include a
URL to whatever Sargun reported?

