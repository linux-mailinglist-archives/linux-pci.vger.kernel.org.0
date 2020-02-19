Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8A5164207
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2020 11:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgBSK0H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Feb 2020 05:26:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:55068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbgBSK0H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Feb 2020 05:26:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C1EE1B2F6;
        Wed, 19 Feb 2020 10:26:05 +0000 (UTC)
Message-ID: <1582107959.9787.10.camel@suse.com>
Subject: Re: system generating an NMI due to 80696f991424d ("PCI: pciehp:
 Tolerate Presence Detect hardwired to zero")
From:   Oliver Neukum <oneukum@suse.com>
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     David Yang <mmyangfl@gmail.com>, Rajat Jain <rajatja@google.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Libor Pechacek <lpechacek@suse.cz>
Date:   Wed, 19 Feb 2020 11:25:59 +0100
In-Reply-To: <20200208203104.vbeafivjn5bevyq5@wunner.de>
References: <1579083986.15925.31.camel@suse.com>
         <20200115112429.yrj5v2zhvxkoupbw@wunner.de>
         <20200116053500.chp4rsbeflg3qrdr@wunner.de>
         <1580904900.9756.9.camel@suse.com>
         <20200208203104.vbeafivjn5bevyq5@wunner.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Samstag, den 08.02.2020, 21:31 +0100 schrieb Lukas Wunner:
> Thanks for testing, so I assume that's a
> 
> Tested-by: Oliver Neukum <oneukum@suse.com>


Yes, this is tested.

	HTH
		Oliver

