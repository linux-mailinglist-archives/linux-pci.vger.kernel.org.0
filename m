Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FE3277BA5
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 00:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgIXW2p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 18:28:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbgIXW2o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 18:28:44 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5031E221EB;
        Thu, 24 Sep 2020 22:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600986524;
        bh=yMqqD4q6MOYWF8EHQtKOwjxNuDID7gqlb8fE8c3n7AA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=L5S2ltYh3vH7a3cPGkL5gN16R7cRxwANWufkU1GhbL5CBTo6oZ5ssyemycitXxrE9
         +zTOZ5P721ezyn4R0YddsYjS613ZonTgh92Po91zO0d2RjzOqp3YbTK9Vu+zREenmZ
         kEG8Vmu60YzNVKiUTAUp+zwL0ByQOzTd7Ydu4N64=
Date:   Thu, 24 Sep 2020 17:28:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/7] PCI/ASPM: Cache device's ASPM link capability in
 struct pci_dev
Message-ID: <20200924222843.GA2365337@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924142443.260861-2-refactormyself@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 24, 2020 at 04:24:37PM +0200, Saheed O. Bolarinwa wrote:
> pcie_get_aspm_reg() reads LNKCAP to learn whether the device supports
> ASPM L0s and/or L1 and L1 substates.

I'm working from this v2 series.  But it's always nice if you include
a cover letter (as you did for the series you posted yesterday) and if
the cover letter includes a note about what changed from the previous
versions.

Bjorn
