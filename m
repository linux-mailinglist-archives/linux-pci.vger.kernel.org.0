Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8CE67A34
	for <lists+linux-pci@lfdr.de>; Sat, 13 Jul 2019 15:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfGMNHk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 Jul 2019 09:07:40 -0400
Received: from nikam.ms.mff.cuni.cz ([195.113.20.16]:51192 "EHLO
        nikam.ms.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfGMNHk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 Jul 2019 09:07:40 -0400
X-Greylist: delayed 521 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Jul 2019 09:07:39 EDT
Received: by nikam.ms.mff.cuni.cz (Postfix, from userid 2587)
        id EF41928251B; Sat, 13 Jul 2019 14:58:56 +0200 (CEST)
Date:   Sat, 13 Jul 2019 14:58:56 +0200
From:   Martin =?utf-8?B?TWFyZcWh?= <mj@ucw.cz>
To:     "return.0" <return.0@me.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: pciutils: decoding extended capabilities with variable size
 based on lane count
Message-ID: <mj+md-20190713.125226.76248.nikam@ucw.cz>
References: <917430A7-9813-4F54-A135-BB965950EE27@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <917430A7-9813-4F54-A135-BB965950EE27@me.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

> I was working on providing a patch for decoding some of the 4.0 extended
> capabilities, but hit a snag.  The Lane Margining and the 16GT/S Physical
> Layer Extended Capabilities only have valid data for the number of lanes (up
> to 32) currently configured. It would be nice to know the width during
> decode without having to re-read and decode, but instead grab it from the
> device structure.

Generally, I like this approach. It however introduces a dependency between
parsing of different capabilities – so far, we did not assume any concrete
order. I think that assuming that extended caps are parsed after all
non-extended ones is OK, but please document it somewhere. Perhaps you can
add a comment to the newly added struct fields explaining when are these set
and when they are used.

				Have a nice fortnight
-- 
Martin `MJ' Mareš                        <mj@ucw.cz>   http://mj.ucw.cz/
United Computer Wizards, Prague, Czech Republic, Europe, Earth, Universe
A sine curve goes off to infinity or at least the end of the blackboard.
