Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB161075E8
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 17:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfKVQhR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 11:37:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:33292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727299AbfKVQhR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 Nov 2019 11:37:17 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A56F220715;
        Fri, 22 Nov 2019 16:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574440637;
        bh=26RHOk/YyE1pWnXH3q5t7AEN9f9yZs8PqAeXk1UdJSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sz/PjHazobTZ13D/TjrUhqg6dNa3rlRZ2xXDKz8k0NTIpcjpObRSr2RKViFQmmiDv
         1rDTVz+Azd5dTDz6BXg6cUXsG2lAUboZupTsGPAiObj4yxXCc5A8trpGkoMq7b4xWJ
         iHgV210iWUD0P3KttCWePeB43DLysfNbZ5yKih+0=
Date:   Sat, 23 Nov 2019 01:37:11 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Remove Keith from VMD maintainer
Message-ID: <20191122163711.GB27120@redsun51.ssa.fujisawa.hgst.com>
References: <20191122162501.27018-1-kbusch@kernel.org>
 <5364bafc4b61e66ff7734ab805abd14d5fa2a5c9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5364bafc4b61e66ff7734ab805abd14d5fa2a5c9.camel@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 22, 2019 at 04:27:43PM +0000, Derrick, Jonathan wrote:
> NAK! Just kidding..
> 
> Acked-by: Jon Derrick <jonathan.derrick@intel.com>

I'm subscribed to linux-pci, but also please CC my @kernel.org account
if you want a second opinion on anything. :)
