Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C488435A1D5
	for <lists+linux-pci@lfdr.de>; Fri,  9 Apr 2021 17:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbhDIPS7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Apr 2021 11:18:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:56674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233798AbhDIPS7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Apr 2021 11:18:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADFF160FE8;
        Fri,  9 Apr 2021 15:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617981526;
        bh=5hw09+kwJkMG2fan9OJTaPhb1zIocHV2fgRHmR9Zy84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=htBTtcEnzEfUlGirejM/zgYaYfEYFaRoepbV6KywKErcrR+zWKqKO000U9Fi4DUo8
         Fvc5o76db+rIMMhUbjxfyNth/zdGmrHY3zNsENOAIQAoWXvsYZA5gWDCuZnekuCXgo
         1GmvcR3e68ufDouLTpUe/HNI7zCFpIsdbiwi5dD42wsrkUub7pQ38VONu5hge+bjsm
         0p6k53lBwzzKxxBTOncbkP051ESZ+AJje+IHASAraO+qBH07szWKnfSsBVxNWcOY+W
         rYNPkhY3wkOupkJkupqnne3f085GadWuHcUh2xx5HLuBH3NRc8nnFccU81AtI25OTw
         E41CJW9dzkfcw==
Date:   Sat, 10 Apr 2021 00:18:39 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     ragas gupta <ragasgupta@zoho.com>
Cc:     linux-pci <linux-pci@vger.kernel.org>
Subject: Re: Function Level Reset notification to PCIe device driver
Message-ID: <20210409151839.GA32304@redsun51.ssa.fujisawa.hgst.com>
References: <178b641aeb9.ec6e71c9132052.6218745065153370962@zoho.com>
 <178b67644d1.107ad1ec3132641.8033434734705028022@zoho.com>
 <178b6784bd7.f1a37c91132657.4038524595161012155@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178b6784bd7.f1a37c91132657.4038524595161012155@zoho.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 09, 2021 at 05:20:40PM +0530, ragas gupta wrote:
> Hello, 
>   
> This query is regarding Function level reset feature for SRIOV. 

Just FYI, FLR support is independent of SRIOV.

> As per code in Linux PCIe driver the function level reset is done by writing “1” to “reset” under sysfs interface. 
> e.g. “echo 1 > /sys/bus/pci/devices/<interface id> /reset “ 
>  
> As function level reset is not triggered via the PCIe device driver how PCIe device driver can get the notification of the function level reset(FLR)? 

Driver's wishing to be notified of the reset can implement the
pci_error_handlers .reset_prepare() and .reset_done() callbacks for the
notification.
