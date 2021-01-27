Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA380305F84
	for <lists+linux-pci@lfdr.de>; Wed, 27 Jan 2021 16:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbhA0PZN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jan 2021 10:25:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:32856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343864AbhA0PXv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 Jan 2021 10:23:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1CC920771;
        Wed, 27 Jan 2021 15:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611760990;
        bh=/QK8GOdLQmHZB+d1F1HXmuQHXgdym25vBsrOecX6Rxg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=corHFPnAaJIWnvjmcJvX0D6K4q7cW/vVgMVS5GJav5/8IulD7wa/NBfdRRFYg5Ho1
         qwIpp6CsOHSqJz3g+6DKdd8e31bZCuij50hIl0JK+SalgdaDFC6GgITjCK59S+CGxR
         cHY6zz3D21QUNAvtWXyvyd1Dn4wWf3esiXBWwIFyFILyQdlsqST97nbUrcB3vomJk/
         WlRJxwfxI4iti7TmqiV7eGAUMv1qJAzfiVcp8oH6c1ZHo8N3KgdKxNulh4z+Zsx6D9
         M+5gi3wITncvdEFcS4jL0byyz8tIF++kEB1SQ/W5CBAV4bC0KHWK2f8rAG7xknBe//
         hm3yNTHrkav0g==
Date:   Wed, 27 Jan 2021 09:23:08 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bharat Kumar Gogada <bharatku@xilinx.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] PCI: xilinx-nwl: Enable coherenct PCIe traffic using CCI
Message-ID: <20210127152308.GA2985356@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR02MB555964381D30E72FC79B4F7CA5BB9@BYAPR02MB5559.namprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 27, 2021 at 05:03:12AM +0000, Bharat Kumar Gogada wrote:
> > On Thu, Jan 21, 2021 at 03:29:16PM +0530, Bharat Kumar Gogada wrote:

> Here is the CCI spec 
> https://developer.arm.com/documentation/ddi0470/k/preface

I'm sure it was obvious, but please include this in the commit log as
well.

> > Can you include a URL to a CCI spec?  I'm not familiar with it.  I
> > guess this is something upstream from the host bridge, i.e.,
> > between the CPU and the host bridge, so it's outside the PCI
> > domain?
