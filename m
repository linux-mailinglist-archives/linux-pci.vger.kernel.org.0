Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC6B89728
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 08:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbfHLGaE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 02:30:04 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:48581 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfHLGaE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Aug 2019 02:30:04 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 4C0352800B3C8;
        Mon, 12 Aug 2019 08:30:02 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 11B331CD08; Mon, 12 Aug 2019 08:30:02 +0200 (CEST)
Date:   Mon, 12 Aug 2019 08:30:02 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Denis Efremov <efremov@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] PCI: pciehp: Add pciehp_set_indicators() to
 jointly set LED indicators
Message-ID: <20190812063002.qbo6yrjvyrgi27go@wunner.de>
References: <20190811195944.23765-1-efremov@linux.com>
 <20190811195944.23765-2-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811195944.23765-2-efremov@linux.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 11, 2019 at 10:59:41PM +0300, Denis Efremov wrote:
> Add pciehp_set_indicators() to set power and attention indicators with a
> single register write. Thus, avoiding waiting twice for Command Complete.
> enum pciehp_indicator introduced to switch between the indicators statuses.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>
