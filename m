Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 557BA99FC7
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 21:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404094AbfHVTVt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 15:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404082AbfHVTVr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Aug 2019 15:21:47 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 181252339F;
        Thu, 22 Aug 2019 19:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566501706;
        bh=Np2YaXFXxdZBVJ/hOPqIyUSMETJCZBthpNL2w89JMWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1F7BZBxHeCFog1GAX51UuT3BSNzZLPdITl8OUGr4YtFjPfvXe5D8A8vrv8IW2QUXQ
         yfZYt6F8ONtacAssm5LcbkffFhy8BABQRWjYLTbPa7nXr2NmKWlbySh50K86Cr6/ug
         c6/fO2V6RfBURrov/0o9B2/rv2iGtbaMxpyOKwOg=
Date:   Thu, 22 Aug 2019 14:21:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Fawad Lateef <fawadlateef@gmail.com>
Cc:     "Schmid, Carsten" <Carsten_Schmid@mentor.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: Unhandled fault: imprecise external abort (0x1406) when loading
 xhci_pci.ko - uPD720202, PEX8605, iMX6Q and linux-4.19.25
Message-ID: <20190822192143.GK14450@google.com>
References: <CAGgoGu5FfLFzCf0QiAd8UcMrZ7gtLyapgT3TZ-Hx0dknWy4LMQ@mail.gmail.com>
 <CAGgoGu4zP_7QpKHiXSkLfkb=zHEezBzstVfjQMQ4CO60+YubCw@mail.gmail.com>
 <CAGgoGu7rot61LSgu2syOMq9Onx26_u3PEtS7pf_QNQRxOaifhg@mail.gmail.com>
 <20190801171725.GD151852@google.com>
 <743ef7fab5144df69bfc8673fff7f0f7@SVR-IES-MBX-03.mgc.mentorg.com>
 <CAGgoGu4ZZR3ZVD5mx_oJN_8gwNM4fa=of=erwM+P8P7zzaMDrQ@mail.gmail.com>
 <CAGgoGu5WP1qQUf4HS8xWGXUuP0L9vM6HGz1OZoGBBh1B67ZYSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGgoGu5WP1qQUf4HS8xWGXUuP0L9vM6HGz1OZoGBBh1B67ZYSg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 22, 2019 at 11:18:44AM +0200, Fawad Lateef wrote:

> In all crash cases (when loading/unloading the driver); system stays
> response, so I can look into any possible device status using PCIe
> registers of PEX8605 switch or iMX6 PCIe root hub. Please suggest if
> something I can check to better understand the issue.

You could collect the output of "sudo lspci -vvxxx" and see if the
switch or root port logged any errors.  Collect it before and after
the crash and compare the two.

Bjorn
