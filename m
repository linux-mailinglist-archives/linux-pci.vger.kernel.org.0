Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4287B4260
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 22:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391635AbfIPUrl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 16:47:41 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55692 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391630AbfIPUrk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2019 16:47:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id g207so772961wmg.5;
        Mon, 16 Sep 2019 13:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rTWOX45cY57shcaylIoJs6ddXiu3evrGLFdFM3nnDoA=;
        b=ToRG7sGoLnEmzb7Y7+fzQ+X8fc0PN7PNw/v90XdWNeK1WBkEKl6r+bM6vB4mO+FCSt
         tlHsQNcftXrLGT7EeKw0kbmK1Uvn5G0W/iY+dkiJlsBTzaEnM1gVubxhZ6PEBF1exsp9
         +8fRG5273rpVgHSBq8aQmzNU/16wGbl92gKct3JCBZMCN2uKbRfUM7XujlczCnkMzgZG
         oC8QOGk35nI4Uue4PaW9vDVDKnYkdUu6Q9vPu/WzCnTgTmDxg15ultbi/SmNWxrTZ30G
         liDO3o3AtcuffN0bi74PVQ97cZJEWOQAJdyLu/LpfOq43evD1IpQukOO1E3ARTw9qRk3
         vGTQ==
X-Gm-Message-State: APjAAAVlNKMZuGYKSzjw7KX81z+pxbICr7CwXD5Tj8ErsuKkIVNxdJ8G
        gbr9IHCT0oQKQxoEUDoRdCQ=
X-Google-Smtp-Source: APXvYqx78NBHu5O0eYvC6JJ4sxSzd+aniNIZ9PxAMOMGGSLl159m95qtqj/2EsOQedkY7MpggXDTFQ==
X-Received: by 2002:a1c:f917:: with SMTP id x23mr694988wmh.101.1568666858204;
        Mon, 16 Sep 2019 13:47:38 -0700 (PDT)
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id x6sm231437wmf.38.2019.09.16.13.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:47:37 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Andrew Murray <andrew.murray@arm.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v3 21/26] serial: 8250_pci: Use PCI_STD_NUM_BARS
Date:   Mon, 16 Sep 2019 23:41:53 +0300
Message-Id: <20190916204158.6889-22-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916204158.6889-1-efremov@linux.com>
References: <20190916204158.6889-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove local definition PCI_NUM_BAR_RESOURCES for the number of PCI BARs
and use global one PCI_STD_NUM_BARS instead.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/tty/serial/8250/8250_pci.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 7f740b37700b..e557605ec75f 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -43,8 +43,6 @@ struct pci_serial_quirk {
 	void	(*exit)(struct pci_dev *dev);
 };
 
-#define PCI_NUM_BAR_RESOURCES	6
-
 struct serial_private {
 	struct pci_dev		*dev;
 	unsigned int		nr;
@@ -74,7 +72,7 @@ setup_port(struct serial_private *priv, struct uart_8250_port *port,
 {
 	struct pci_dev *dev = priv->dev;
 
-	if (bar >= PCI_NUM_BAR_RESOURCES)
+	if (bar >= PCI_STD_NUM_BARS)
 		return -EINVAL;
 
 	if (pci_resource_flags(dev, bar) & IORESOURCE_MEM) {
@@ -3583,7 +3581,7 @@ serial_pci_guess_board(struct pci_dev *dev, struct pciserial_board *board)
 		return -ENODEV;
 
 	num_iomem = num_port = 0;
-	for (i = 0; i < PCI_NUM_BAR_RESOURCES; i++) {
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		if (pci_resource_flags(dev, i) & IORESOURCE_IO) {
 			num_port++;
 			if (first_port == -1)
@@ -3611,7 +3609,7 @@ serial_pci_guess_board(struct pci_dev *dev, struct pciserial_board *board)
 	 */
 	first_port = -1;
 	num_port = 0;
-	for (i = 0; i < PCI_NUM_BAR_RESOURCES; i++) {
+	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		if (pci_resource_flags(dev, i) & IORESOURCE_IO &&
 		    pci_resource_len(dev, i) == 8 &&
 		    (first_port == -1 || (first_port + num_port) == i)) {
-- 
2.21.0

