Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4132FBF2D
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jan 2021 19:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390549AbhASSjY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jan 2021 13:39:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:58508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387837AbhASSi6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Jan 2021 13:38:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A93C320706;
        Tue, 19 Jan 2021 18:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611081497;
        bh=s/pWD7FoVuVYMrmPIWXlLOO5buA2t96fHRA4dSMWljM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iDjLlMJ5OvgsPp5+iMN/SvzHzZcaoWg55NhGu5D5n/czhLio0AEmI8nimamjkvU5F
         Qp9e0DBiMymzw7AW0qzx7EeED83jOXsnSTHSPOWpBhpf0cBQxtBzfc6u9vwhLD3vpj
         AwpHZUIE8liH4q9MhnRfXfRFReBZr/RBujEozaPI=
Date:   Tue, 19 Jan 2021 19:38:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ntb@googlegroups.com
Subject: Re: [PATCH v9 10/17] PCI: endpoint: Allow user to create
 sub-directory of 'EPF Device' directory
Message-ID: <YAcnFiExcr5o4FKa@kroah.com>
References: <20210104152909.22038-11-kishon@ti.com>
 <20210119183405.GA2496684@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119183405.GA2496684@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 19, 2021 at 12:34:05PM -0600, Bjorn Helgaas wrote:
> [cc->to Greg]
> 
> On Mon, Jan 04, 2021 at 08:59:02PM +0530, Kishon Vijay Abraham I wrote:
> > Documentation/PCI/endpoint/pci-endpoint-cfs.rst explains how a user
> > has to create a directory in-order to create a 'EPF Device' that
> > can be configured/probed by 'EPF Driver'.
> > 
> > Allow user to create a sub-directory of 'EPF Device' directory for
> > any function specific attributes that has to be exposed to the user.
> 
> Maybe add an example sysfs path in the commit log?
> 
> Seems like there's restriction on hierarchy depth in sysfs, but I
> don't remember the details.  Moved Greg to "to" in case he wants to
> comment.

This is configfs, not sysfs, so I really do not know, sorry.

greg k-h
