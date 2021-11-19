Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5F045735B
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 17:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbhKSQsS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 11:48:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:49846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236705AbhKSQsI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 11:48:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6279A61B30;
        Fri, 19 Nov 2021 16:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637340306;
        bh=+SoitjM0+lKnhQAjTwigzcw0+IDYVVOuBTj+IPdnIkA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UEu87MrFLO6k+twrYK1a/DJoX/x941kY0Y/wwBRquH13EzTc3UA3LOtu4/R2YTWMk
         HXrGlCH/Vt3ZGQXtaXaFKZLqObDmBU1nXVcIaIuCWVh55BeRvagQLMhad0hiaWqoRe
         4BCaxopIZzf0s+C7qN1a1kpz76JAyfNEx8+1GLlVbKONJbPG4nnWLh1moBSq32Tr/j
         6ajSEuyp7TM8eAK848pdKpiP2JPhuvFO5bqVjjmPtaG8zBsvpFJJOs76VFPhnBgWVd
         rmPM8NTvB745e4PnPnD8m08nRPiihOGAGQIxiZRlQAx+tXTKTRfrN/IPZVffVnA2Ll
         2/j7q7oTkZgZA==
Message-ID: <6e196006-9c0d-d4ae-f350-538d4ab1c4db@kernel.org>
Date:   Fri, 19 Nov 2021 11:45:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: Query about secondary_bu_reset implementation
Content-Language: en-US
To:     Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, hch@lst.de
Cc:     Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        thierry.reding@gmail.com, linux-pci@vger.kernel.org
References: <40b03450-8f42-29d5-b65e-43644ec44940@nvidia.com>
 <0cc150cd-664f-05de-c8eb-81c81583cad7@nvidia.com>
 <4925ab12-2406-916c-7594-f23de3ede068@kernel.org>
 <916f7fb6-9f29-80d5-e6c0-fd68032161c4@nvidia.com>
From:   Sinan Kaya <okaya@kernel.org>
In-Reply-To: <916f7fb6-9f29-80d5-e6c0-fd68032161c4@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/19/2021 11:20 AM, Vidya Sagar wrote:
> 
> 
> On 11/19/2021 12:16 AM, Sinan Kaya wrote:

>> We have seen some GPUs going all the way up to 60 seconds while
>> returning CRS response and waiting to reinitialize.
> Yes, but the pci_dev_wait() is called here with the pci_dev * of the RP 
> and not the endpoint, right? So, how is CRSes from the endpoint are 
> handled in this case?

I see what you are saying. Yes, that looks like a bug. It should have
been a config space read to the EP.
