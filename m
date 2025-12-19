Return-Path: <linux-pci+bounces-43406-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AD9CD0845
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 16:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5362730BC50F
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 15:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0427B33CE95;
	Fri, 19 Dec 2025 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXdQBjNe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2E9316917;
	Fri, 19 Dec 2025 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766157929; cv=none; b=LwsGcTu7+s1v7Qj9I+kxTPss1eELkIaxsmy9Org1Paw8rx1buVoZIum273MsXCPVGI40yBSGf/rhFsjxAizsQjwsziWVac3ofekIeBsIqlNO5oVeLk5y1JuBO4UHoBPHqtmafB8pDB4tlHAJ+OW7Ag63DVZFffPSlOg0YlFGaI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766157929; c=relaxed/simple;
	bh=b7ZQFUmybQOKOhzGs8UkdT5AC/ICY2hLdh/vjkXWyaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLNfqNOTEPA8NQgvi/4Qy+Uj44iih+zscgYGlD91FR3+egCGU/qBvfL6tvOmJ0TZMq5XCvoYCW64l8vt/EGvahH8HD08d3ohhaPVTjxEycvfRGmVc/qNhnHt1oEuDUZw+Vy/0MFgZUuG1wHY1T60d1hZjaApmbWbZ4qvMn9uAbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXdQBjNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CBE9C4CEF1;
	Fri, 19 Dec 2025 15:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766157929;
	bh=b7ZQFUmybQOKOhzGs8UkdT5AC/ICY2hLdh/vjkXWyaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RXdQBjNeX/Bqk7SOAQ72GTn3XZquDe5oklsreC30NWFztnWgXtzQSwF9jGWbVn/I6
	 7Hh5EkuMS+vQpFwkPmzBV/PNP+2hu1UlCpDlwGni6IP1a56PJCHV4xFHtj3ahvfIPl
	 thEwGdmZNBh1oXSr5lMQeVpJy3763/VIA8VtKdQQYSItwyL6JJd0fit0SKrAXZkszI
	 +i1AuoFPa1FaJ+F0MC/l1g+D3pUXdm6rUK2dpjyBfkbSVaE82+H+ffmY3Gg6Jf7Oev
	 suyBS6/QJH9dyyTzLZVYVOZ9EKRUdjCiGXTKGj6PKIQja/M15mChjIqq5EYrn79+V/
	 SL75hkgARsRQg==
Date: Fri, 19 Dec 2025 09:25:26 -0600
From: Rob Herring <robh@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	iivanov@suse.de, svarbanov@suse.de, mbrugger@suse.com,
	Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH 0/4] Fix RP1 DeviceTree hierarchy and drop overlay support
Message-ID: <20251219152526.GA3333129-robh@kernel.org>
References: <cover.1766077285.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1766077285.git.andrea.porta@suse.com>

On Thu, Dec 18, 2025 at 08:09:05PM +0100, Andrea della Porta wrote:
> The current RP1 implementation is plagued by several issues, as follows:
> 
> - the node name for RP1 is too specific and should be generic instead
>   (see [1]).
> 
> - the fully defined DTS has its PCI hierarchy wrongly described. There
>   should be a PCI root port between the root complex and the endpoint
>   (see [1]).
> 
> - since CONFIG_PCI_DYNAMIC_OF_NODES can be dropped in the future
>   becoming an automatically enabled feature, it would be wise to not
>   depend on it (see [2]).
> 
> - overlay support has led to a lot of confusion. It's not really usable 
>   right now and users are not even used to it (see [3]).
> 
> This patch aims at solving the aforementioned problems by amending the
> PCI topology as follows:
> 
>   ...
>   pcie@1000120000 {
>     ...
> 
>     pci@0,0 {
>       device_type = "pci";
>       reg = <0x00 0x00 0x00 0x00 0x00>;
>       ...
> 
>       dev@0,0 {
>         compatible = "pci1de4,1";
>         reg = <0x10000 0x00 0x00 0x00 0x00>;
>         ...
> 
>         pci-ep-bus@1 {
>           compatible = "simple-bus";
>           ...
> 
>           /* peripherals child nodes */
>         }; 
>       }; 
>     }; 
>   }; 
> 
> The reg property is important since it permits the binding the OF
> device_node structure to the pci_dev, encoding the BDF in the upper
> portion of the address.
> 
> This patch also drops the overlay support in favor of the fully
> described DT while streamlining it as a result.
> 
> Links:
> [1] - https://lore.kernel.org/all/aTvz_OeVnciiqATz@apocalypse/
> [2] - https://lore.kernel.org/all/CAL_JsqJUzB71QdMcxJtNZ7raoPcK+SfTh7EVzGmk=syo8xLKQw@mail.gmail.com/
> [3] - https://lore.kernel.org/all/CAL_JsqJUzB71QdMcxJtNZ7raoPcK+SfTh7EVzGmk=syo8xLKQw@mail.gmail.com/
> 
> Andrea della Porta (4):
>   dt-bindings: misc: pci1de4,1: add required reg property for endpoint
>   misc: rp1: drop overlay support
>   arm64: dts: broadcom: bcm2712: fix RP1 endpoint PCI topology
>   arm64: dts: broadcom: rp1: drop RP1 overlay

Thanks for doing this.

Reviewed-by: Rob Herring <robh@kernel.org>

