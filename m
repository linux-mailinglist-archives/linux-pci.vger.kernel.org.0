Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACFA42CD9B
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 00:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhJMWO7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 18:14:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230153AbhJMWO7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Oct 2021 18:14:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A64161151;
        Wed, 13 Oct 2021 22:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634163175;
        bh=u/bQLZfhgnTnBbANf/qHToPTgbfBAr7b4QRmI0DM+VQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Pucg75TZ34Ae7T9jQ+XgW7e3rakhnRpGxYCSWvo2KxWvClG4ZbIKbtjeC2UVH+oO7
         iVoNz/cLB6cSajRUNncbKcrPGbXD+ShoH15SzmVOLk+06vQmt6Z/lB063sUIpLOTmw
         R1laj0u3CVt86yKRk6JI9fS1kR5UQXiBp7dmZdRiInrPT8zKXLqikFm+SUZILmBlek
         41SxPxZsmdwemO4Ok3cqgzGZGIl2UTjmWHhgRpCimk10jJ02LX/h899Uur3nfBbMeH
         coJjsSJGtt5f3YMjTcOCBHPuG+mnNeFJ3lz3CO5q4I8oPbVyKrgmbMtI3WATZIFq6J
         SQrjktw55/ahg==
Date:   Wed, 13 Oct 2021 17:12:53 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH 02/22] PCI: Unify PCI error response checking
Message-ID: <20211013221253.GA1928518@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqL0d4qOR+wsnpdRUc+EQ6_diUzPbMj3Tv-Ly29or6Asvw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 13, 2021 at 04:47:43PM -0500, Rob Herring wrote:

> Presumably, there could be some register somewhere where all 1s is
> valid? So I think we need the error values.

We have to assume ~0 is a valid value for any config registers except
the few defined by the spec that have bits required to be 0.  There
can be all kinds of vendor-defined stuff in config space that can be
anything.

> Also, I seem to recall only the vendor/device IDs are defined to be
> all 1s for non-existent devices. Other errors are undefined?

I think this case is actually an instance of the PCI controller
fabricating ~0 because a PCI/PCIe error occurred (I think on PCI it's
a Master Abort when nothing responds; on PCIe the read terminates as
an Unsupported Request (PCIe r5.0, sec 2.3.2)).
