Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA182A28D8
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 12:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgKBLP1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 06:15:27 -0500
Received: from imap2.colo.codethink.co.uk ([78.40.148.184]:37150 "EHLO
        imap2.colo.codethink.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728288AbgKBLP1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 06:15:27 -0500
Received: from cpc79921-stkp12-2-0-cust288.10-2.cable.virginm.net ([86.16.139.33] helo=[192.168.0.10])
        by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1kZXo6-0002Qd-60; Mon, 02 Nov 2020 11:15:26 +0000
Subject: Re: [PATCH v17 3/3] PCI: microchip: Add host driver for Microchip
 PCIe controller
To:     Daire.McNamara@microchip.com, linux-pci@vger.kernel.org
References: <20201022132223.17789-4-daire.mcnamara@microchip.com>
 <587df2af-c59e-371a-230c-9c7a614824bd@codethink.co.uk>
 <MN2PR11MB426909C2B84E95AF301C404B96100@MN2PR11MB4269.namprd11.prod.outlook.com>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <2eee84c9-aa24-2587-5ced-1c2fe30a1d50@codethink.co.uk>
Date:   Mon, 2 Nov 2020 11:15:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <MN2PR11MB426909C2B84E95AF301C404B96100@MN2PR11MB4269.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 02/11/2020 10:39, Daire.McNamara@microchip.com wrote:
> Hi Ben,
> 
> Yes, we've become aware of an issue that's cropped up with latest design file on Icicle with PCIe.  We're working through it and we'll update once we have resolved it.

Thanks for looking at this.

We could really do with this working as we need faster storage
and graphics options for what we want to do with these boards.

I am happy to reinstall or rebuild images, i've got a v5.9 that
works to an extent on the icicles.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
