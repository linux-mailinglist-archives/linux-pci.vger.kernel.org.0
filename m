Return-Path: <linux-pci+bounces-40206-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD99C314ED
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 14:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02892188F9BE
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 13:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C122F0C6D;
	Tue,  4 Nov 2025 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NrJDpdPr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E222BDC09;
	Tue,  4 Nov 2025 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264307; cv=none; b=j6+GVD216QAZSwich4+49p/IxuKa4o9djgmuPxMhtH/RckD8km8IwQOCqHHQeA+gs/ja5n8LBXsgSUIMaODNYWGV8C+Hc72cnYe4HQWLyq5+hJMP8E8IHGRvOoU+itPHc5kEvDxEOs6uGXWVCheGV9I80U8wqSNPboUYt0JQAH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264307; c=relaxed/simple;
	bh=XmIivvsEE1ElTiYOq+o0LhnD2SE5CRozSm+NJdh/Xpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQb+BVC/0XkKWOjZQ7rLiBQK1F340U4Za+U4gUXMtIDRPk8Jgu0yV07gbwIMzqWx8I9jJ6A8z1HAo725bnb3rc2qQZyMS9MVC8wYvmAi2LTNlWHuaPkUBZf80ISO4MypTDFXByXFq4m0A0m+P/AodFRe3/IwBbY30aWv4Wr5Sfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NrJDpdPr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D1CC4CEF7;
	Tue,  4 Nov 2025 13:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762264307;
	bh=XmIivvsEE1ElTiYOq+o0LhnD2SE5CRozSm+NJdh/Xpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NrJDpdPrTAu2w5YGjc1yuRNmhhjyhtu0uhGAqNFetWy3WnsGEcRL02J6z3QYqrK8I
	 wl3ryjH/pp0eFqZbo4aAq+WPFw7Kam158iRR9I7uUqmJBQqK1JOnAKAFfy31ruVbrW
	 NXcjenwn7+2ip5dTEA8yj6zi1Y6tzEt83otWnAanIrBMZt4YI0wQ8KYfyld8nYtVLf
	 uSEIl6Pr7PrT9IJ42HGane1NWpOC6PqUD84XAb5uH9Quaywnq8uphg8WrWCtC84inE
	 TkTZ9JATHAOEmp0MUURN+ORuy+zoURaqBAH31IfYnBHBC9853PxCQFoibxViP7F1uk
	 VN1tkovRxcr2w==
Date: Tue, 4 Nov 2025 08:51:46 -0500
From: Sasha Levin <sashal@kernel.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.17-6.12] PCI: Set up bridge resources earlier
Message-ID: <aQoE8hB29pu1WMbh@laps>
References: <20251025160905.3857885-1-sashal@kernel.org>
 <20251025160905.3857885-86-sashal@kernel.org>
 <4b5020d1-51c1-a556-175b-a4c4e1995c61@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b5020d1-51c1-a556-175b-a4c4e1995c61@linux.intel.com>

On Mon, Oct 27, 2025 at 02:39:27PM +0200, Ilpo Järvinen wrote:
>On Sat, 25 Oct 2025, Sasha Levin wrote:
>
>> From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>
>> [ Upstream commit a43ac325c7cbbfe72bdf9178059b3ee9f5a2c7dd ]
>>
>> Bridge windows are read twice from PCI Config Space, the first time from
>> pci_read_bridge_windows(), which does not set up the device's resources.
>> This causes problems down the road as child resources of the bridge cannot
>> check whether they reside within the bridge window or not.
>>
>> Set up the bridge windows already in pci_read_bridge_windows().
>>
>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> Link: https://patch.msgid.link/20250924134228.1663-2-ilpo.jarvinen@linux.intel.com
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>This change was reverted by the commit 469276c06aff ("PCI: Revert early
>bridge resource set up").

Dropped, thanks!

-- 
Thanks,
Sasha

