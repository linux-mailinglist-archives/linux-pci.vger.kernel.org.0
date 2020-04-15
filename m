Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2319E1AAEB6
	for <lists+linux-pci@lfdr.de>; Wed, 15 Apr 2020 18:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410440AbgDOQtf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Apr 2020 12:49:35 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:65085 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410438AbgDOQte (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Apr 2020 12:49:34 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 492Sxl3MgwzCQ;
        Wed, 15 Apr 2020 18:49:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1586969372; bh=zQDxlVQ+piC9JeNkcZ3DClymWipO5QIxOiWvmOQrRLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B/QM4E1pGqKlysASRsHvl9yQ3uVcn8woliFG/rbdg+oI2cRTYALDxN2QolwTPxslh
         MP+VpcMd0ulYBRblEV40na0OvFgLXnoLNiv9lni4tOJhDYfYoTGl6VGl4lOd90MxLo
         3t5YaJhTPURGMBqNmagAprSYc94+TMlnQQwxQ8RJV+ea7Gyuc+f5hAQRgq1xjHX1S/
         umiiQgRUC7TLBWZTVkReOAdYrfMZP0laeyddnbKWzAshf9sjs4yvVUUD5TFTTVStw8
         ZZMv5Be+3dtlImpiE1IdyTeuHTYSGBxtIusJiSRqXUOMNtSG8VLftCh6UNPkeX3xrX
         g9CFETMP941fQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Wed, 15 Apr 2020 18:49:30 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Pali =?iso-8859-2?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Fix reporting GPIO error value
Message-ID: <20200415164930.GF19897@qmqm.qmqm.pl>
References: <20200414102512.27506-1-pali@kernel.org>
 <20200414113104.GA27984@qmqm.qmqm.pl>
 <20200415111736.czeh7a3iqmmasow6@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200415111736.czeh7a3iqmmasow6@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 15, 2020 at 01:17:36PM +0200, Pali Rohár wrote:
> On Tuesday 14 April 2020 13:31:04 Micha³ Miros³aw wrote:
> > On Tue, Apr 14, 2020 at 12:25:12PM +0200, Pali Rohár wrote:
> > > Error code is stored in rp->reset_gpio and not in err variable.a
[...]
> > > -				dev_err(dev, "failed to get reset GPIO: %d\n",
> > > -					err);
> > > +				dev_err(dev, "failed to get reset GPIO: %ld\n",
> > > +					PTR_ERR(rp->reset_gpio));
> > >  				return PTR_ERR(rp->reset_gpio);
> > >  			}
> > >  		}
> > 
> > You can use %pe directly on the pointer for added benefit of translation
> > of the error to a name.
> 
> Well, I do not know what is the current preferred style of error
> messages. On lot of places I see just numeric error numbers.

%pe is quite a recent addition to the kernel (since v5.3).

Best Regards
Micha³ Miros³aw
