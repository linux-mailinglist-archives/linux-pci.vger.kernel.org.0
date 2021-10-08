Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE48426F55
	for <lists+linux-pci@lfdr.de>; Fri,  8 Oct 2021 19:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhJHRHr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Oct 2021 13:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231217AbhJHRHr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Oct 2021 13:07:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFB4A60F92;
        Fri,  8 Oct 2021 17:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633712752;
        bh=7kTIwLlgRp0iDs1cBmHL2s0Lz6D5wpQ13P8G7hwfwHU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XYMfQwSv0q8lwftf+OFgxpV89YKNDcdVihFUHcLKr30vJcCseb6MRhMXweW40Q50n
         c+Vsrf5ReO4V5uEF6HEL9FcVNT/3+Px07w2bZVa97XCw+NDf4BTgGOVWJ6sToLSkbJ
         CxBmA29RdR2uCFybTxpT+cm671Gaq7v7FFNTlmGTNsbnDTAE/fMNwc7BEVbhhTBlvY
         eAtjkv4VgIDTRJ+2d+WOb1tTZvRUTJeO740yI67blEqD7rvoYCdhOgxaBK1T8r/Gdm
         9LOaCvLdoZs7/E2kyyd03QJLwYQp8UKSj9hj5JR7+/+nYTYH98OsZONNlwBFMh3NfK
         2cO6QkOTebBeA==
Date:   Fri, 8 Oct 2021 12:05:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     kelvin.cao@microchip.com
Cc:     kurt.schwemmer@microsemi.com, logang@deltatee.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kelvincao@outlook.com
Subject: Re: [PATCH 0/5] Switchtec Fixes and Improvements
Message-ID: <20211008170550.GA1352932@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924110842.6323-1-kelvin.cao@microchip.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 24, 2021 at 11:08:37AM +0000, kelvin.cao@microchip.com wrote:
> From: Kelvin Cao <kelvin.cao@microchip.com>
> 
> Hi,
> 
> Please find a bunch of patches for the switchtec driver collected over the
> last few months.

Question: Is there a reason this driver should be in drivers/pci/?

It doesn't use any internal PCI core interfaces, e.g., it doesn't
include drivers/pci/pci.h, and AFAICT it's really just a driver for a
PCI device that happens to be a switch.

I don't really *care* that it's in drivers/pci; I rely on Kurt and
Logan to review changes.  The only problem it presents for me is that
I have to write merge commit logs for the changes.  You'd think that
would be trivial, but since I don't know much about the driver, it
does end up being work for me.

Bjorn
