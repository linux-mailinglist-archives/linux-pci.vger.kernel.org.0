Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B69494D7E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 12:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbiATL5f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 06:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbiATL5e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 06:57:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776A7C061574;
        Thu, 20 Jan 2022 03:57:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 161E9614B9;
        Thu, 20 Jan 2022 11:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD932C340E0;
        Thu, 20 Jan 2022 11:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642679853;
        bh=J9yCPRxNgwHF3+Ta+2Qkq3JMYTM+kuO4Z0znjDOPNqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tK+l0/oYIX0r4VNk3nStcVlefV38W5QtP7/TP8lKOMI2jhp2YhbxqhXe/WD+qsjb3
         ldxsJ/uGYd6dcMuEoL7E+q7W9scg4S2Mds0uOfvxKH6i6zGRl2V1tOMomxu2vC0yZk
         pqfeZahj8YEo0ykmPCZkWAfhzGdG9yulvzGdIyaM=
Date:   Thu, 20 Jan 2022 12:57:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Li Chen <lchen.firstlove@zohomail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?utf-8?Q?=22Krzysztof_Wilczy=C5=84ski=22?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3] misc: pci_endpoint_test: simplify endpoint test read
 and write operations
Message-ID: <YelOKkg4SIiRJmz5@kroah.com>
References: <17e76f86155.1222b3923123229.7199263965880267375@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17e76f86155.1222b3923123229.7199263965880267375@zohomail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 20, 2022 at 06:11:36PM +0800, Li Chen wrote:
> Introduce pci_endpoint_epf_transfer_data to simplify
> read and write operations.
> 
> Signed-off-by: Li Chen <lchen@ambarella.com>

Does not match the From: line.  Please read the documentation for how to
fix this up and add a From: line to the email body itself.

thanks,

greg k-h
