Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29BC1FC15D
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 00:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgFPWFH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Jun 2020 18:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbgFPWFG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Jun 2020 18:05:06 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70AC520739;
        Tue, 16 Jun 2020 22:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592345105;
        bh=9bH3nkbMis+3M+lEU06ECFeAOUKxNtoZ5l6kTuWtHJ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NjFR2rOLvjf1Fl8aIw/KJ8pg7rdNAzn+ldbAARieoWv6tfX23tuZTCAG/lBok9e3H
         sgtWezY0YeOjBEX/eyBS6rW1QM7IkGdvUIF4plMokntwY7lOSSWG+ay7TIm9Hv/iwb
         tGfciR+AzZ5vTi9M3+jj17AmDOmEqBbHiBZRS5ps=
Date:   Tue, 16 Jun 2020 17:05:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 03/12] dt-bindings: PCI: Add bindings for more Brcmstb
 chips
Message-ID: <20200616220504.GA1983902@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616205533.3513-4-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 16, 2020 at 04:55:10PM -0400, Jim Quinlan wrote:
> From: Jim Quinlan <jquinlan@broadcom.com>
> 
> - Add compatible strings for three more Broadcom STB chips: 7278, 7216,
>   7211 (STB version of RPi4).
> - add new property 'brcm,scb-sizes'
> - add new property 'resets'
> - add new property 'reset-names' for 7216 only
> - allow 'ranges' and 'dma-ranges' to have more than one item and update
>   the example to show this.

Capitalize and add periods to the list items consistently.
