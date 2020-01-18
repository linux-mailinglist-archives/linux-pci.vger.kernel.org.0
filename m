Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A30A141841
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jan 2020 16:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgARPQA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 18 Jan 2020 10:16:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:48666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgARPP7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 18 Jan 2020 10:15:59 -0500
Received: from localhost (237.sub-174-231-6.myvzw.com [174.231.6.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07CD72468D;
        Sat, 18 Jan 2020 15:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579360559;
        bh=9aVTZNrOxL5uerEBx8NH1RMZX7XT3l/reo54BDaSk+w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bQAR9RQN1l0PZUnqYqckhbQyU/K1TLV1XyU6su/J88WYh3kzZRg5h+844Uv/FHqjj
         mOjtMNcNlSZQTFRZb30PynXs365DTmja5RXunJHMk1w/RqLZxbkAts79OSg0yRgYxZ
         I+xnF/CheA6aOJPF6AvF9i8ixavx8lExO7Fm6aHg=
Date:   Sat, 18 Jan 2020 09:15:57 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
Subject: Re: [PATCH v12 0/8] Add Error Disconnect Recover (EDR) support
Message-ID: <20200118151557.GA146679@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1571702-b1bb-b956-c1ad-7eb917eae82e@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 17, 2020 at 05:10:00PM -0800, Kuppuswamy Sathyanarayanan wrote:
> On 1/17/20 4:18 PM, Bjorn Helgaas wrote:

> > -	obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 5,
> > -				EDR_PORT_LOCATE_DSM, NULL);
> > +	obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 5, EDR_PORT_LOCATE_DSM, NULL);
>
> This line goes over 80 chars, do you still want to keep them in same line ?

Nope, sorry, I must have accidentally widened my window.  Make it so
it fits in 80 columns.
