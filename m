Return-Path: <linux-pci+bounces-39588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5001C1739C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 23:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC3E3A674E
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 22:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0343369988;
	Tue, 28 Oct 2025 22:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmwArIjV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D27B35A959;
	Tue, 28 Oct 2025 22:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761691680; cv=none; b=ifKODRWepDtnHsTmpiwAtwwlD12us3IPkYNcztb70AwLiIbPH+DWOsrTfVXtrO+wsrshrtw7QJjy3wjsEKPNGQdpIN/5d1BRSnl/pQ86LKe3tdXLoHyFhvufIMDcisMlOOP0lY4LlUPcEZOniPyVOis9qBq5m6WOfj6/wo83MN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761691680; c=relaxed/simple;
	bh=qWCNJkz7G5kmgkjItiMMD20/rWK6sIe2D2tpj5lmW3A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cXt4PobXVoSOMW9tCubAUzryUGkL4Mkd3iV+QvovkuEjojTz2/rGr6x4LoKm7TVwfykMDsBkNGyORpCsjYl3Hgxk2+bJOCH6mBMKAHLN+cHV9xd+KxOVHAPQUvCsts9ZS6W90K8qgVZUxY/Psq4QdJl1Hp5IsB2mlzhdRENHOcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmwArIjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01B9AC4CEE7;
	Tue, 28 Oct 2025 22:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761691680;
	bh=qWCNJkz7G5kmgkjItiMMD20/rWK6sIe2D2tpj5lmW3A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HmwArIjVmW8ZpIrz3CEexx0H8UxetNHoA4swDIeIC2/eCkYoFQvq/9JQsu+JDe2Kt
	 TfNMcTHuPPd9fvk2Zk/Z5mdGW5Su+btMax0c+AI4bomEbFc9T3oVz5rM6IJ1ob0cKm
	 JwNFWZtVJhYQxsqO45vfQ4WGguzBc3szfopyBZLkErta8RAHphVzS+WxzZzogn6VUR
	 PER50o5qeF9ztrsiy1o77q9wp2a++cMLpLQHdgEOG3VkC8Qk4a02Qy1pYfv3Q75brZ
	 EqRXTqE1JjeKe/w5FqZRaiqjjgzq2gNJDjnBzyOCMC7/cyIzoCThGa0dky4WHa+3wY
	 WHi89qwbGzH/w==
Date: Tue, 28 Oct 2025 17:47:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Val Packett <val@packett.cool>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Guenter Roeck <linux@roeck-us.net>, regressions@lists.linux.dev
Subject: Re: [PATCH 1/2] PCI: Setup bridge resources earlier
Message-ID: <20251028224758.GA1539235@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251013210116.GA864145@bhelgaas>

On Mon, Oct 13, 2025 at 04:01:16PM -0500, Bjorn Helgaas wrote:
> On Mon, Oct 06, 2025 at 05:00:25AM -0300, Val Packett wrote:
> > On 9/24/25 10:42 AM, Ilpo Järvinen wrote:
> > > Bridge windows are read twice from PCI Config Space, the first read is
> > > made from pci_read_bridge_windows() which does not setup the device's
> > > resources. It causes problems down the road as child resources of the
> > > bridge cannot check whether they reside within the bridge window or
> > > not.
> > > 
> > > Setup the bridge windows already in pci_read_bridge_windows().
> > > 
> > > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > 
> > Looks like this change has broken the WiFi (but not NVMe) on my Snapdragon
> > X1E laptop (Latitude 7455):
> ...

> #regzbot introduced: a43ac325c7cb ("PCI: Set up bridge resources earlier")
#regzbot fix: 469276c06aff ("PCI: Revert early bridge resource set up")

