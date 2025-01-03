Return-Path: <linux-pci+bounces-19263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07992A00FED
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 22:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8885162ED4
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 21:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F401B6CF5;
	Fri,  3 Jan 2025 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYcDKnnN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A70145B03;
	Fri,  3 Jan 2025 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735940328; cv=none; b=TypoProqDLgREv/FUu8NM/xPXH3Kc3G4WA1Rxw3u4ki50psQgyeG3qYPTkVqru6MmzM/00mb24tYi19fhRKocdrRrRr5ZF3PQoYa/sQtWmZVFrwFMOlpUROqKLi+jNci39rc4Pnf9t5egspgNbM9Gt1FYRmsQn9mos618MsvtGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735940328; c=relaxed/simple;
	bh=ls3yow1I+58TqbMY+jtm0N4DPSP9udn3q1vqQVKrbhI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iofQSdDbNyI/+E9+kai5SHAhN2DbApqQlvRPKqyDEHcKM8q6K5uhPAyVMIGjz+bN8Vn90mb0W7GjCJliotrPLnHnUct/MebJ0wBmhyc7rcqKUoskrxG8vbNckGppFhP0HcaS+Cp+KrjLXFL7p5eKc+sIQ+4H6f6eJUstriUVwJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYcDKnnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E34C4CECE;
	Fri,  3 Jan 2025 21:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735940328;
	bh=ls3yow1I+58TqbMY+jtm0N4DPSP9udn3q1vqQVKrbhI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aYcDKnnN8pTYXS/u3aVhTyg+W4LzKV9vk/zI+noRMw1cKU1Buhq6I9ii2ic8UJjfe
	 RuVQv4/hsox9In3G2cetUEzhH1z8uFJJO5kwaYRXgTSieNrAJDxwsdIS5izQ6UR72y
	 nLcONc9W9Oa/fKTvIcshl496DwEpqkFQ39UPdbM3P4a6kGC3aEoqFUd2/WmnclGSed
	 OgndYODOPBERRj2HKbDyYDq81LH0FO6GZePMfEVqKFYIGzNHxHvS0Ah0H+f/bMkr1r
	 jF4aHVfuUZNJf9hRBbv5e55cRZrU+V5loCnCHoNrs+ffbYdKLgLUXolaZgA8ZTnRB/
	 a8e5NmtoPM7RA==
Date: Fri, 3 Jan 2025 15:38:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] PCI: of: Simplify bus range parsing
Message-ID: <20250103213846.GA6313@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103213129.5182-3-helgaas@kernel.org>

On Fri, Jan 03, 2025 at 03:31:28PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> of_pci_parse_bus_range() looks for a DT "bus-range" property.  If none
> exists, devm_of_pci_get_host_bridge_resources() defaults to the [bus 00-ff]
> range supplied by its caller, pci_parse_request_of_pci_ranges().
> 
> devm_of_pci_get_host_bridge_resources() is static and has no other callers,
> so there's no reason to complicate its interface by passing the default bus
> range.
> 
> Drop the busno and bus_max parameters and use 0x0 and 0xff directly in
> devm_of_pci_get_host_bridge_resources().

Since we default this if the DT lacks "bus-range", is there any point
in repeating "bus-range = <0x00 0xff>;" in all the host bridge
descriptions?

> @@ -343,8 +340,8 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
>  
>  	err = of_pci_parse_bus_range(dev_node, bus_range);
>  	if (err) {
> -		bus_range->start = busno;
> -		bus_range->end = bus_max;
> +		bus_range->start = 0;
> +		bus_range->end = 0xff;
>  		bus_range->flags = IORESOURCE_BUS;
>  		dev_info(dev, "  No bus range found for %pOF, using %pR\n",
>  			 dev_node, bus_range);

