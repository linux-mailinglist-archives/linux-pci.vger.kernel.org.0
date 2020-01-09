Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74DD81358D7
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 13:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbgAIMG6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 07:06:58 -0500
Received: from foss.arm.com ([217.140.110.172]:58102 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728653AbgAIMG6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jan 2020 07:06:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22B6031B;
        Thu,  9 Jan 2020 04:06:58 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E05543F534;
        Thu,  9 Jan 2020 04:06:56 -0800 (PST)
Date:   Thu, 9 Jan 2020 12:06:51 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     Dilip Kota <eswara.kota@linux.intel.com>,
        linux-pci@vger.kernel.org, helgaas@kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH 1/1] PCI: dwc: intel: fix nitpicks
Message-ID: <20200109120651.GA10919@e121166-lin.cambridge.arm.com>
References: <457c714ba7a73075291778b3436fd96feca7c532.1576144419.git.eswara.kota@linux.intel.com>
 <20191213103602.GL24359@e119886-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213103602.GL24359@e119886-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 13, 2019 at 10:36:03AM +0000, Andrew Murray wrote:
> I'll ask Lorenzo to squash this in when he returns.

Done, pushed out on pci/dwc, thanks !

Lorenzo
