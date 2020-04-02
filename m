Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D93C219C877
	for <lists+linux-pci@lfdr.de>; Thu,  2 Apr 2020 20:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389178AbgDBSBy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Apr 2020 14:01:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388641AbgDBSBy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 2 Apr 2020 14:01:54 -0400
Received: from localhost (mobile-166-170-223-166.mycingular.net [166.170.223.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8492206F6;
        Thu,  2 Apr 2020 18:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585850514;
        bh=oWUzlHfuwWKgME7NjSzkRgepanaeIaWsrH5an+W0Uds=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Wl70XaZIn/iM6huN3hAgmn9HJGzsCtMrt2DpC4VSkh0dGXZTMNkgiOcLnej8YzzGd
         /UK/KnXqbbXwH6woCGQii3desEhyWPv/wEWByxZfPPyC7m5NkJaIOWYB0yxPvXYhnN
         VddlJvK//g5/zZtXqbmks5qmJS7XkSODgKXNYoic=
Date:   Thu, 2 Apr 2020 13:01:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-usb@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        tim.gover@raspberrypi.org, linux-pci@vger.kernel.org,
        wahrenst@gmx.net, sergei.shtylyov@cogentembedded.com
Subject: Re: [PATCH v6 1/4] soc: bcm2835: Sync xHCI reset firmware property
 with downstream
Message-ID: <20200402180151.GA50169@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324182812.20420-2-nsaenzjulienne@suse.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 24, 2020 at 07:28:09PM +0100, Nicolas Saenz Julienne wrote:
> The property is needed in order to trigger VL805's firmware load. Note
> that there is a gap between the property introduced and the previous
> one. This is also the case downstream.

I don't know what "downstream" means, so I don't know what we're
syncing *with*.  If there's another branch or project we need to
coordinate with, is there a name or URL that would help facilitate
that?  If not, I'm not sure what value that sentence adds.

Bjorn
