Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A49274B4C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 23:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgIVVnB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 17:43:01 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50240 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgIVVnB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Sep 2020 17:43:01 -0400
X-Greylist: delayed 966 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 17:43:00 EDT
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kKpoG-00Fnl5-T3; Tue, 22 Sep 2020 23:26:48 +0200
Date:   Tue, 22 Sep 2020 23:26:48 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-pci@vger.kernel.org, mtosatti@redhat.com,
        sassmann@redhat.com, jeffrey.t.kirsher@intel.com,
        jacob.e.keller@intel.com, jlelli@redhat.com, hch@infradead.org,
        bhelgaas@google.com, mike.marciniszyn@intel.com,
        dennis.dalessandro@intel.com, thomas.lendacky@amd.com,
        jerinj@marvell.com, mathias.nyman@intel.com, jiri@nvidia.com
Subject: Re: [RFC][Patch v1 1/3] sched/isolation: API to get num of
 hosekeeping CPUs
Message-ID: <20200922212648.GA3764123@lunn.ch>
References: <20200909150818.313699-1-nitesh@redhat.com>
 <20200909150818.313699-2-nitesh@redhat.com>
 <20200921234044.GA31047@lenoir>
 <fd48e554-6a19-f799-b273-e814e5389db9@redhat.com>
 <20200922100817.GB5217@lenoir>
 <b0608566-21c6-8fc9-4615-aa00099f6d04@redhat.com>
 <20200922205805.GD5217@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922205805.GD5217@lenoir>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Subject: Re: [RFC][Patch v1 1/3] sched/isolation: API to get num of hosekeeping CPUs

Hosekeeping? Are these CPUs out gardening in the weeds?

	     Andrew
