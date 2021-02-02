Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2812F30BBD2
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 11:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhBBKMH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 05:12:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:46334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229570AbhBBKMG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 05:12:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 21D8A64DD1;
        Tue,  2 Feb 2021 10:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612260685;
        bh=KNcH9sjzQJ5GgNGIRMnH4szcrBtKnEMWDLKCwAErbzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WaNeg+I8cFjFe6klcQAI69e2zY4CRmjXotkipP9x4ghFhSmnN4nEOrCl7DvChHnSz
         yi3EzXlxu8NwsssxFzwqxVboGOdk03wryW64crwCgfpU1oCXf82yRKMf5ycTe9OaAY
         7OU5FJ+Gs93RHFmAKB83o5sdhZW1zJ/BzauPWP+w=
Date:   Tue, 2 Feb 2021 11:11:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] misc: Add Add Synopsys DesignWare xData IP driver
Message-ID: <YBklScf1HPCVKQPf@kroah.com>
References: <cover.1605777306.git.gustavo.pimentel@synopsys.com>
 <DM5PR12MB183527AA0FECE00D7A3D46DBDAB59@DM5PR12MB1835.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR12MB183527AA0FECE00D7A3D46DBDAB59@DM5PR12MB1835.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 02, 2021 at 08:51:10AM +0000, Gustavo Pimentel wrote:
> Just a kindly reminder.

reminder of what?
