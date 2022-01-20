Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CE8494917
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 09:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239037AbiATIGg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 03:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239073AbiATIGf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 03:06:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DABC061574;
        Thu, 20 Jan 2022 00:06:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B097B81CF3;
        Thu, 20 Jan 2022 08:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7ABC340E0;
        Thu, 20 Jan 2022 08:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642665992;
        bh=PmiMV0t7mhLQk/T/YeFoQc1Sgo6/eIde/nZQM7npMDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bLA2kiBJHgzpiL5i+T04PCof9LWOE3LZoyj4htUXiHx5+2DPX4xyxI2NVEYu8OotU
         6avbMoO9HMQ2ds0qwgpadO1wrkKHNwMF1s47U0KiAJqyvZdQ1FW934kTskRAbwbdXw
         RXCXjOdRhNQdySXBWSTHIwlteILQtYP9ltYhnbIc=
Date:   Thu, 20 Jan 2022 09:06:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Li Chen <lchen@ambarella.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] misc: pci_endpoint_test: simplify endpoint test read and
 write operations
Message-ID: <YekYAAHPEBeJflZN@kroah.com>
References: <SA1PR19MB5572EAD4025173FA9F3B3937A05A9@SA1PR19MB5572.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR19MB5572EAD4025173FA9F3B3937A05A9@SA1PR19MB5572.namprd19.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 20, 2022 at 08:03:17AM +0000, Li Chen wrote:
> **********************************************************************
> This email and attachments contain Ambarella Proprietary and/or Confidential Information and is intended solely for the use of the individual(s) to whom it is addressed. Any unauthorized review, use, disclosure, distribute, copy, or print is prohibited. If you are not an intended recipient, please contact the sender by reply email and destroy all copies of the original message. Thank you.

Now deleted.
